class Timeslot < ActiveRecord::Base
	belongs_to :ca
	
	def add_30min(starttime)
		if not starttime.nil?
			return nil
		end
		endtime = Time.parse(starttime) + 30*60
		return endtime.hour.to_s << ":" << endtime.min.to_s
	end
end
