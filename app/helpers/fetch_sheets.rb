require 'byebug'
require 'date'
require_relative 'google_api_authorization'
require_relative '../mailers/scheduler_mailer'


# $service = Google::Apis::SheetsV4::SheetsService.new
# $service.client_options.application_name = APPLICATION_NAME
# $service.authorization = authorize

SPREADSHEET_ID = '1uO5sg1kHQJ7rgDJSL1jXf1ww7rkEP0nRYBTQbjZwWCQ' # need to put at env var file, this changes over time. 
CELL_RANGE = 'A2:F' # need to put at env var file

# Google::Apis::ClientError
    
def fetch_month_sheets()
    for day in ('1'..'31').to_a
        range = day + "!" + CELL_RANGE
        info_list = get_sheet_response(range)
        detect_change_send_email(info_list)
    end 
end

def get_sheet_response(range)
    $service.get_spreadsheet_values(SPREADSHEET_ID, range).values # mock this
end

def detect_change_send_email(info_list)
    str_date = info_list[0][0].split(" ")[0].split("/")
    date = Date.new(str_date[2].to_i,str_date[0].to_i,str_date[1].to_i)
    for row in info_list[3..-1]
        if not Timeslot.find_by_date_and_time(date,row[0]).nil? and \
            not Timeslot.find_by_date_and_time(date,row[0])[:client_name].nil? and \
            row.length == 2
            
            ca_id = Ca.find_by_name(row[1].downcase)[:id]
            # send cancellation email
            SchedulerMailer.cancellation_email(ca_id).deliver_now
        elsif not Timeslot.find_by_date_and_time(date,row[0]).nil? and \
            Timeslot.find_by_date_and_time(date,row[0])[:client_name].nil? and \
            row.length == 6
            
            # this will error out if ca name is not right
            ca_id = Ca.find_by_name(row[1].downcase)[:id]
            # find timeslot
            ts = Timeslot.find_by_date_and_time_and_ca_id(date, row[0], ca_id)
            ts.update({
                    	:client_name => row[2].downcase,
                    	:phone_number => row[3],
                    	:apt_number => row[4],
                    	:current_tenant => row[5]
            })
            # send new schedule notification email
            SchedulerMailer.new_schedule_notification_email(ca_id).deliver_now
        end
    end
    return false
    
end

# for CA putting their availability
def write_to_spreadsheet(row, name, email)
    requests = []
    requests.push({
    update_cells: {
      start: {sheet_id: 0, row_index: row, column_index: 0},
      rows: [
        {
          values: [
            {
                user_entered_value: {string_value: name}
            }
          ]
        }
      ],
      fields: 'userEnteredValue'
    }
    })
    requests.push({
    update_cells: {
    start: {sheet_id: 0, row_index: row, column_index: 2},
    rows: [
      {
        values: [
          {
            user_entered_value: {string_value: email}
          }
        ]
      }
    ],
    fields: 'userEnteredValue'
    }
    })
    batch_update_request = {requests: requests}
    $service.batch_update_spreadsheet($spreadsheet_id, batch_update_request, {})
end

        
    
        