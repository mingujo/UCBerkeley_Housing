class Admin < ActiveRecord::Base
	def self.get_by_email(email)
	    return find_by(email: email)
	end
end
