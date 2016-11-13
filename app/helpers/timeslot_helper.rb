require 'time'

module TimeslotHelper
	
	def add_30min(starttime)
		if starttime.nil?
			return nil
		end
		return starttime + 30*60
	end
	
end
