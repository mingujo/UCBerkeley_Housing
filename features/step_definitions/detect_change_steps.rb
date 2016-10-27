require 'byebug'

Given /^the following is fetched from a spreadsheet of one day:$/ do |timeslot_table|
	$mock_timeslots = {}
	timeslot_table.hashes.each_with_index do |ts, i|
		$mock_timeslots[i] = ts[:client]
	end
	expect(timeslot_table.hashes.size).to eq $mock_timeslots.length
end

Given /^the following timeslots of that day exists:$/ do |timeslot_table|
    timeslot_table.hashes.each do |ts|
        Timeslot1.create!({:time => ts["time"], 
	                       :CA_id => ts["rating"], 
	                       :client_name => ts["client_name"],
	                       :phone_number => ts["phone_number"],
        				   :apt_number => ts["apt_number"],
        				   :current_tenant => ts["current_tenant"]
        })
    end
    expect(Timeslot1.distinct.count('id')).to eq timeslot_table.hashes.size
end


Given /^the e-mail address of "([^"]*)" be "([^"]*)"$/ do |name, email|
	Ca.create!({:name => name, :email => email})
	expect(Ca.find_by_name(name)[:name]).to eq name
	expect(Ca.find_by_email(email)[:email]).to eq email
end

Then /^"([^"]*)" gets a "([^"]*)" email:$/ do |name, kind|
	
end