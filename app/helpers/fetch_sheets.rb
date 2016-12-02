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

=begin
    Get id of the spreadsheet for the corresponding month and year, taken from a datetime object.
    date_time = either current date/time or a timeslot's starttime. 
    Methods that check for changes will only look at the current month. But when writing to the spreadsheet,
    we need to know if the change is being made to this month's sheet or next month's sheet
=end

def get_spreadsheet_id(date_time)
    month = date_time.strftime("%m").to_i
    year = date_time.strftime("%Y").to_i
    id = Spreadsheet.get_id_by_date(month, year)
    return id
end


# This portion just fetches data from spreadsheet using API (has to be mocked)
# :nocov:
def get_sheet_response(range)
    spreadsheet_id = get_spreadsheet_id(Time.now) #gets id of spreadsheet of current month
    $service.get_spreadsheet_values(spreadsheet_id, range).values # mock this
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



#--------------Write to Spreadsheet----------------------

#TODO: write CA info to spreadsheet the first time that they add their schedule there


#return starttime of timeslot in format: hour:min
def get_starttime(timeslot)
    return timeslot.starttime.strftime("%I:%M")
end


# format time so that it is in format: h:m
# so that hour is not zero-padded, and takes out the seconds 
# ie: 04:30:00 => 4:30
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

# find row number corresponding to the starttime of the appointment
def find_row(starttime, sheet_ID)
    spreadsheet_id = get_spreadsheet_id(starttime)
    vals = $service.get_spreadsheet_values(spreadsheet_id, "#{sheet_ID}!A1:B" ).values
    # vals = list representation of the cells in the spreadsheet
    row = 0
    while (starttime != format_time(vals[row][0])) do
        row += 1
    end
    return row
end

# this is for the CA name column
def get_CA(timeslot)
    id = timeslot.ca_id
    ca = Ca.find(id)
    return ca
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
    spreadsheet_id = get_spreadsheet_id(date_time)
    $service.update_spreadsheet_value(spreadsheet_id, range, value_range, value_input_option: "USER_ENTERED")
end
# :nocov:


# when a CA has listed availabilites on a certain day on the spreadsheet, 
# their name, email and phone number should be listed on the bottom.
def write_ca_info_to_spreadsheet(timeslot)
    #...
end

def write_to_spreadsheet(timeslot)
    #needs to lookup spreadsheet ID in spreadsheet ID model: has 2 columns, month: 1-12, and IDs

    day = get_day(timeslot)
    starttime = get_starttime(timeslot)
    row = find_row(starttime, day)
    range = "#{day}!B#{row}"
    ca_name = get_CA(timeslot).name
    write_sheet_values(range, [[ca_name]], timeslot.starttime)
    write_ca_info_to_spreadsheet(timeslot)
end



def remove_name_from_spreadsheet(timeslot)
    day = get_day(timeslot)
    starttime = get_starttime(timeslot)
    row = find_row(starttime, day)
    range = "#{day}!B#{row}"
    write_sheet_values(range, [[""]])
end




# --------------Generate Spreadsheet -----------------


#TODO: create the template sheet, so that admin can just create the new spreadsheet and doesn't have to create the first page
# this entails requiring input of date of first day in month in the view



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


#WILL REMOVE THIS
# ensure that the date on the first spreadsheet is properly formatted. 
# alternatively, will change it so that user can enter date in view and then we write it to spreadsheet.
def validate_date(spreadsheet_id)
    date = get_date_array(spreadsheet_id)
    if date[0].to_i >= 1 and date[0].to_i <= 12 and date[1].to_i == 1 and date[2].to_i >= 2016 and get_start_day(date[3]) != nil
        return true
    else
        return false
    end
end



# writes date of sheet, which is on the second row.
# format: month/date/year weekday
def set_date_of_sheet(date, spreadsheet_id)
    day = date.day
    month = date.month
    year = date.year
    weekday = date.strftime('%A')
    formatted_date = "#{month}/#{day}/#{year} #{weekday}"
    range = "#{day}!A2"                #sheet_name = date
    write_sheet_values(range, [[formatted_date]], date)
end




# makes copy sheet_id, which defaults to zero. the copy appears as last sheet
# return id of new sheet

def copy_sheet(spreadsheet_id, sheet_id = 0)
    sheet_id = 408995429
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



# date = Date object; can do date.month, date.day, date.year...

def create_new_sheet(date, spreadsheet_id)
    new_sheet_id = copy_sheet(spreadsheet_id)
    set_name_of_sheet(date.day.to_s, new_sheet_id, spreadsheet_id)
    set_date_of_sheet(date, spreadsheet_id)
end




#date = Date object of first day of month

def populate_spreadsheet(date, new_spreadsheet_id)
    month = date.month
    x = 0
    
    #while date.month == month do 
    date = date.tomorrow #probably will do this in func that generates the template sheet
    while x < 2
        create_new_sheet(date, new_spreadsheet_id)
        date = date.tomorrow
        x += 1
    end
end


id = "1tIuyylSNMianWOxUQCvHhYQGb8tONDDVyliWQemWwBM"
