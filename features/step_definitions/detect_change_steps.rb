require 'byebug'
require 'date'

# can we mock list not hash
Given /^the following is fetched from a spreadsheet of one day:$/ do |timeslot_table|
	$info_list = timeslot_table.raw 
	# expect(timeslot_table.hashes.size).to eq $mock_timeslots.length
end

Given /^the following timeslots of that day exists:$/ do |timeslot_table|
    str_date = timeslot_table.raw[0][0].split(" ")[0].split("/")
    date = Date.new(str_date[2].to_i,str_date[0].to_i,str_date[1].to_i)
    timeslot_table.raw.each_with_index do |ts, idx|
    	if idx == 3
    		Timeslot.create({:date => date, 
    						 :time => ts[0], 
    						 :ca_id => Ca.find_by_name(ts[1].downcase)[:id]})
    	elsif idx == 5
	        Timeslot.create!({:date => date,
	        				   :time => ts[0], 
		                       :ca_id => Ca.find_by_name(ts[1].downcase)[:id], 
		                       :client_name => ts[2].downcase,
		                       :phone_number => ts[3],
	        				   :apt_number => ts[4],
	        				   :current_tenant => ts[5]
	        })
		end
    end
    expect(Timeslot.distinct.count('id')).to eq ['Henri','Elissa'].length
end


Given /^the e-mail address of "([^"]*)" be "([^"]*)"$/ do |name, email|
	Ca.create!({:name => name.downcase, :email => email})
	expect(Ca.find_by_name(name.downcase)[:name]).to eq name.downcase
	expect(Ca.find_by_email(email)[:email]).to eq email
end

Then /^"([^"]*)" gets a "([^"]*)" email:$/ do |name, kind|
	# run my function
	pending
end
