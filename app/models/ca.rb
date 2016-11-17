class Ca < ActiveRecord::Base
	has_many :timeslots
	
	def self.get_by_email(email)
	    return find_by(email: email)
	end
end
