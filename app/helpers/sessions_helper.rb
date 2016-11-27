module SessionsHelper
	
	# TODO: maybe this is not this simple
	
	def signed_in?
		if not session.key?("user_id")
			return false
		else
			return true
		end
	end

end