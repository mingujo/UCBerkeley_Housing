require 'time'
require_relative 'google_api_authorization'
require_relative '../mailers/scheduler_mailer'

NEW_SCHEDULE = "new_schedule"
CANCELLATION = "cancellation"

if not ENV['TESTING_ENV']
    $service = Google::Apis::SheetsV4::SheetsService.new
    $service.client_options.application_name = APPLICATION_NAME
    $service.authorization = authorize
end

def fetch_month_sheets()
    for day in ('1'..'2').to_a
        range = day + "!" + ENV["CELL_RANGE"]
        info_list = get_sheet_response(range)
        detect_change_send_email(info_list)
    end 
end

def get_sheet_response(range)
    $service.get_spreadsheet_values(ENV["SPREADSHEET_ID"], range).values # mock this
end

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
