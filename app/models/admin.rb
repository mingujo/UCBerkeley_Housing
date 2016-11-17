class Admin < ActiveRecord::Base
	def self.get_by_email(email)
	    return find_by(email: email)
	end
	
	def self.get_by_user_id(id)
		return find_by(user_id: id)
	end
end
