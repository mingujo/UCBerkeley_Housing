require 'byebug'
module EventsHelper
	
	def make_event_json(events, ca_id=nil)
		lst = []
		events.each do |event|
			if ca_id and event.ca_id != ca_id.to_i
				next
			end
			
			ts = Timeslot.where(:ca_id => event.ca_id, :starttime => event.start_time).first
			if not ts.blank? and not ts.client_name.nil?
				lst << {:id => event.id, 
						:ca_name => Ca.find(event.ca_id).name,
						:client_name => ts.client_name,
						:phone_number => ts.phone_number,
						:apt_number => ts.apt_number,
						:current_tenant => ts.current_tenant,
						:start => "#{event.start_time.iso8601}", 
						:end => "#{event.end_time.iso8601}", 
						:recurring => (event.event_series_id)? true: false}
			else
				lst << {:id => event.id, 
						:ca_name => Ca.find(event.ca_id).name,
						:start => "#{event.start_time.iso8601}", 
						:end => "#{event.end_time.iso8601}", 
						:recurring => (event.event_series_id)? true: false}
			end
		end
		
		return lst
	end
	
end