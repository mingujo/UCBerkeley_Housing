require 'time'
require 'google_api_authorization'
require 'byebug'
#require_relative '../mailers/scheduler_mailer'


NEW_SCHEDULE = "new_schedule"
CANCELLATION = "cancellation"

# This portion just initializes the Google API 
# :nocov:
if not ENV['TESTING_ENV']
    $service = Google::Apis::SheetsV4::SheetsService.new
    $service.client_options.application_name = APPLICATION_NAME
    $service.authorization = authorize
end


$service = Google::Apis::SheetsV4::SheetsService.new
$service.client_options.application_name = APPLICATION_NAME
$service.authorization = authorize
# :nocov:

# This portion is only for cron job scheduler. 
# This is only for looping 31 days of a month
# This function uses detect_change_send_email function which is tested already
# :nocov:
def fetch_month_sheets()
    for day in ('1'..'2').to_a
        range = day + "!" + ENV["CELL_RANGE"]
        info_list = get_sheet_response(range)
        detect_change_send_email(info_list)
    end 
end
# :nocov:

# This portion just fetches data from spreadsheet using API (has to be mocked)
# :nocov:
def get_sheet_response(range)
    $service.get_spreadsheet_values(ENV["SPREADSHEET_ID"], range).values # mock this
end
# :nocov:

def detect_change_send_email(info_list)
    str_date = info_list[0][0].split(" ")[0]
    
    # ONE SAD PATH: if there is no ca and scheduler puts the client name, it will error out
    # ONE SAD PATH: check if client is being replaced
    
    for row in info_list[3..-1]
        starttime = Time.parse(str_date + " " + row[0])
        # find ts
        ts = Timeslot.find_by_starttime(starttime)
        # find ca
        ca = Ca.find_by_name(row[1].downcase)
        if not ts.nil? and not ca.nil?
            # find ca_id
            ca_id = ca[:id]
            if row.length == 6 and ts[:client_name].nil?
                # update timeslot
                update_ts(ts, row[2].downcase, row[3], row[4], row[5])
    
                # send new schedule notification email
                SchedulerMailer.send_email(ca_id, NEW_SCHEDULE).deliver_now
                
            elsif row.length == 2 and not ts[:client_name].nil?
                # update timeslot
                update_ts(ts, nil, nil, nil, nil)
                
                # send cancellation email
                SchedulerMailer.send_email(ca_id, CANCELLATION).deliver_now
            end
        end
    end
    
    return false
end

def update_ts(ts, client_name, phone_number, apt_number, current_tenant)
    ts.update({
            	:client_name => client_name,
            	:phone_number => phone_number,
            	:apt_number => apt_number,
            	:current_tenant => current_tenant
    })
end


def get_starttime(timeslot)
    return timeslot.starttime.strftime("%I:%M")
    #format => hour:min
end

def format_time(time)
    first_colon = time.index(':')
    if first_colon.nil? 
        #if it's not a time
        return time
    end
    second_colon = time.index(':', first_colon + 1)
    result = time[0, first_colon]
    if result.length < 2
        result = "0#{result}"
    end
    if second_colon.nil?
        second_colon = time.length
    end
    result += time[first_colon, second_colon - first_colon]
    return result
end


def find_row(starttime, sheet_ID)
    #list representation of the cells in the spreadsheet
    vals =  $service.get_spreadsheet_values(ENV["SPREADSHEET_ID"], "#{sheet_ID}!A1:B" ).values
    row = 0
    while (starttime != format_time(vals[row][0])) do
        row += 1
    end
     byebug
    return row
end

# this is for the CA name column
def get_CA_name(timeslot)
    id = timeslot.ca_id
    ca = Ca.find(id)
    return ca.name
end

# to determine sheet ID in range
def get_day(timeslot)
    return timeslot.starttime.strftime("%d").to_i
end

# :nocov:

def write_sheet_values(range, values)
    value_range = Google::Apis::SheetsV4::ValueRange.new
    value_range.values = values
    value_range.range = range
    #$service.update_spreadsheet_value(ENV["SPREADSHEET_ID"], range, value_range, value_input_option: "USER_ENTERED")
    a = $service.update_spreadsheet_value("1AZz5QK3aTJdBv5x5V30OAutjm9ugcQXnezP8tfRSwok", range, value_range, value_input_option: "USER_ENTERED")
end
# :nocov:

def write_to_spreadsheet(timeslot)
    #needs to lookup spreadsheet ID in spreadsheet ID model: has 2 columns, month: 1-12, and IDs

    day = get_day(timeslot)
    starttime = get_starttime(timeslot)
    row = find_row(starttime, day)
    range = "#{day}!B#{row}"
    ca_name = get_CA_name(timeslot)
    write_sheet_values(range, [[ca_name]])
end



# create sheet 0, the template sheet to be copied, in the new spreadsheet
def set_template_sheet(spreadsheet_id)
    
 #return this for now
 return $service.get_spreadsheet("1AZz5QK3aTJdBv5x5V30OAutjm9ugcQXnezP8tfRSwok").sheets[0]
end


# makes copy sheet_id, which defaults to zero. the copy appears as last sheet
# return id of new sheet

def copy_sheet(spreadsheet_id, sheet_id = 0)
    copy_request = Google::Apis::SheetsV4::CopySheetToAnotherSpreadsheetRequest.new
    copy_request.destination_spreadsheet_id = spreadsheet_id
    new_sheet_properties = $service.copy_spreadsheet(spreadsheet_id, sheet_id, copy_request)
    return new_sheet_properties.sheet_id
end


# name: day of the month; a string
def change_name_of_sheet(name, sheet_id,spreadsheet_id)
    #initialize the requests
    
    #BatchUpdateRequest attribute: array of Requests
        # Request attribute: update_sheet_properties = UpdateSheetPropertiesRequest
            #UpdateSheetPropertiesRequest attributes: fields, properties
    property_update_request = Google::Apis::SheetsV4::UpdateSheetPropertiesRequest.new
    name_change_request = Google::Apis::SheetsV4::Request.new
    batch_update_request = Google::Apis::SheetsV4::BatchUpdateSpreadsheetRequest.new
    
    #set the actual property to change
    property_update_request.fields = "title"
    property_update_request.properties = {sheet_id: sheet_id, title: name}
    
    #assign the requests
    name_change_request.update_sheet_properties = property_update_request
    batch_update_request.requests = [name_change_request]
    
    #call the update
    $service.batch_update_spreadsheet(spreadsheet_id, batch_update_request) 
end

def create_new_sheet(name, spreadsheet_id)
    new_sheet_id = copy_sheet(spreadsheet_id)
    change_name_of_sheet(name, new_sheet_id, spreadsheet_id)
end


def generate_spreadsheet(days_in_month)

    new_spreadsheet_id = "1AZz5QK3aTJdBv5x5V30OAutjm9ugcQXnezP8tfRSwok" #need to actually create a new one
    #set_template_sheet(new_spreadsheet_id) //still need to implement this; figure out how to set access when creating a new spreadsheet
    
    (2..days_in_month).each do |day|
        create_new_sheet(day.to_s, new_spreadsheet_id)
    end
    
end





#http://www.rubydoc.info/github/google/google-api-ruby-client/Google/Apis/SheetsV4/SheetsService#create_spreadsheet-instance_method
#https://github.com/google/google-api-ruby-client/blob/master/generated/google/apis/sheets_v4/classes.rb