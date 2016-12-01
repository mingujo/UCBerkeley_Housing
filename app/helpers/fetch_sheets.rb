require 'time'
require 'google_api_authorization'
require 'signet/oauth_2/client'
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
    $service.get_spreadsheet_values(get_spreadsheet_id(Time.now), range).values # mock this
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
    vals = $service.get_spreadsheet_values(get_spreadsheet_id(starttime), "#{sheet_ID}!A1:B" ).values
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

def write_sheet_values(range, values, date_time)
    value_range = Google::Apis::SheetsV4::ValueRange.new
    value_range.values = values
    value_range.range = range
    #$service.update_spreadsheet_value(ENV["SPREADSHEET_ID"], range, value_range, value_input_option: "USER_ENTERED")
   $service.update_spreadsheet_value(get_spreadsheet_id(date_time), range, value_range, value_input_option: "USER_ENTERED")
end
# :nocov:

def write_to_spreadsheet(timeslot)
    #needs to lookup spreadsheet ID in spreadsheet ID model: has 2 columns, month: 1-12, and IDs

    day = get_day(timeslot)
    starttime = get_starttime(timeslot)
    row = find_row(starttime, day)
    range = "#{day}!B#{row}"
    ca_name = get_CA_name(timeslot)
    write_sheet_values(range, [[ca_name]], timeslot.starttime)
end


def remove_name_from_spreadsheet(timeslot)
    day = get_day(timeslot)
    starttime = get_starttime(timeslot)
    row = find_row(starttime, day)
    range = "#{day}!B#{row}"
    write_sheet_values(range, [[""]])
end


 # get id of the spreadsheet for the corresponding month and year, taken from a datetime object
 # date_time = either current date/time or a timeslot's starttime
def get_spreadsheet_id(date_time)
    month = date_time.strftime("%m").to_i
    year = date_time.strftime("%y").to_i
    id = Spreadsheet.get_url_by_date(month, year)
    return id
end



# --------------Generate Spreadsheet -----------------




# incoming date format: "month/date/year day"

def get_date_array(spreadsheet_id)
    full_date = $service.get_spreadsheet_values(spreadsheet_id, "1!A2").values[0][0]
    month = /^[0-9]+/.match(full_date).to_s
    date = /\/[0-9]+/.match(full_date).to_s
    date = full_date[1..date.length - 1]
    year = /\d{4}/.match(full_date).to_s
    day = /[A-Za-z]+/.match(full_date).to_s
    return [month, date, year, day]
end

def validate_date(spreadsheet_id)
    date = get_date_array(spreadsheet_id)
    if date[0].to_i >= 1 and date[0].to_i <= 12 and date[1].to_i == 1 and date[2].to_i >= 2016 and get_start_day(date[3]) != nil
        return true
    else
        return false
    end
end


# return day of week, string

def get_weekday(date)
    weekdays = { 1 => "Monday", 2 => "Tuesday", 3 => "Wednesday", 4 => "Thursday", 5 => "Friday", 6 => "Saturday", 7 => "Sunday"}
    return weekdays[date%8]
end


# returns number of day that the month starts at

def get_start_day(weekday)
    weekdays = {"Monday" => 1, "Tuesday" => 2, "Wednesday" => 3, "Thursday" => 4, "Friday" => 5, "Saturday" => 6, "Sunday" => 7}
    return weekdays[weekday]
end



def set_date_of_sheet(date, full_date, weekday_tracker, spreadsheet_id)
    month = full_date[0]
    year = full_date[2]
    weekday = get_weekday(weekday_tracker)
    formatted_date = "#{month}/#{date}/#{year} #{weekday}"
    range = "#{date}!A2"                #sheet_name = date
    write_sheet_values(range, [[formatted_date]])
end




# makes copy sheet_id, which defaults to zero. the copy appears as last sheet
# return id of new sheet

def copy_sheet(spreadsheet_id, sheet_id = 0)
    sheet_id = 1587703089
    copy_request = Google::Apis::SheetsV4::CopySheetToAnotherSpreadsheetRequest.new
    copy_request.destination_spreadsheet_id = spreadsheet_id
    new_sheet_properties = $service.copy_spreadsheet(spreadsheet_id, sheet_id, copy_request)
    return new_sheet_properties.sheet_id
end


# name: day of the month; a string

def set_name_of_sheet(name, sheet_id, spreadsheet_id)
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



#name = sheet_name = date (1-31)

def create_new_sheet(name, date_arr, weekday_tracker, spreadsheet_id)
    new_sheet_id = copy_sheet(spreadsheet_id)
    set_name_of_sheet(name, new_sheet_id, spreadsheet_id)
    set_date_of_sheet(name, date_arr, weekday_tracker, spreadsheet_id)
end




#user passes in spreadsheet ID and creates the first sheet. then we make copies of it and change name and sheet id
    #from first sheet, we get month/date/year day

def populate_spreadsheet(days_in_month, new_spreadsheet_id, link)
    full_date = get_date_array(new_spreadsheet_id) 
    weekday_tracker = get_start_day(full_date[3]) #int that keeps track of day of week
    (2..days_in_month).each do |d|
        create_new_sheet(d.to_s, full_date, weekday_tracker, new_spreadsheet_id)
        weekday_tracker += 1
    end
    
    Spreadsheet.create(month: full_date[0], year: full_date[2], url: new_spreadsheet_id, link: link)
end

