require 'time'
include TimeslotHelper
require 'byebug'
require_relative '../../app/helpers/fetch_sheets'

# can we mock list not hash
Given /^the following is fetched from a spreadsheet of one day:$/ do |timeslot_table|
	$info_list = timeslot_table.raw
	for idx in (0...$info_list.length).to_a
		$info_list[idx] -= [""]
	end
end

Given /^the following timeslots of that day exists:$/ do |timeslot_table|
    str_date = timeslot_table.raw[0][0].split(" ")[0]
    timeslot_table.raw.each_with_index do |ts, idx|
    	starttime = Time.parse(str_date + " " + ts[0])
		if ts[1].downcase == "henri"
			Timeslot.create!({:starttime => starttime,
							 :endtime => add_30min(starttime),
							 :ca_id => Ca.find_by_name(ts[1].downcase)[:id]})
		elsif ts[1].downcase == "elissa"
		    Timeslot.create!({:starttime => starttime,
							 :endtime => add_30min(starttime),
							 :ca_id => Ca.find_by_name(ts[1].downcase)[:id], 
							 :client_name => ts[2].downcase,
							 :phone_number => ts[3],
							 :apt_number => ts[4],
							 :current_tenant => ts[5]
			})
		elsif ts[1].downcase == "jane"
    		Timeslot.create!({:starttime => starttime,
							 :endtime => add_30min(starttime),
    						 :ca_id => Ca.find_by_name(ts[1].downcase)[:id]})
		end
    end
    expect(Timeslot.distinct.count('id')).to eq ['Henri','Elissa','Jane'].length
end


Given /^the e-mail address of "([^"]*)" be "([^"]*)"$/ do |name, email|
	if email == "TEST_GUY_EMAIL_ADDR"
		email = ENV["TEST_GUY_EMAIL_ADDR"]
	end
	Ca.create!({:name => name.downcase, :email => email})
	expect(Ca.find_by_name(name.downcase)[:name]).to eq name.downcase
	expect(Ca.find_by_email(email)[:email]).to eq email
end

Then /^"([^"]*)" gets a "([^"]*)" email for date: "([^"]*)", time: "([^"]*)"$/ do 
														|name, kind, str_date, time|
	# run my function
	detect_change_send_email($info_list)
	# test
	starttime = Time.parse(str_date << " " << time)
	name = name.downcase
	if kind == "cancellation"
		expect(Timeslot.find_by_starttime_and_ca_id(starttime,Ca.find_by_name(name)[:id]) \
						[:new_schedule_email_sent]).to eq false
		expect(Timeslot.find_by_starttime_and_ca_id(starttime,Ca.find_by_name(name)[:id]) \
						[:cancellation_sent]).to eq true
	elsif kind == "new_schedule_notification"
		expect(Timeslot.find_by_starttime_and_ca_id(starttime,Ca.find_by_name(name)[:id]) \
						[:new_schedule_email_sent]).to eq true
		expect(Timeslot.find_by_starttime_and_ca_id(starttime,Ca.find_by_name(name)[:id]) \
						[:cancellation_sent]).to eq false	
	end
end

Then /^"([^"]*)" does not get any email for date: "([^"]*)", time: "([^"]*)"$/ do 
														|name, str_date, time|
	# run my function
	detect_change_send_email($info_list)
	# test
	starttime = Time.parse(str_date << " " << time)
	name = name.downcase

	expect(Timeslot.find_by_starttime_and_ca_id(starttime,Ca.find_by_name(name)[:id]) \
					[:new_schedule_email_sent]).to eq false
	expect(Timeslot.find_by_starttime_and_ca_id(starttime,Ca.find_by_name(name)[:id]) \
					[:cancellation_sent]).to eq false
end