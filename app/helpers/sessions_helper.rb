module SessionsHelper
	
	def signed_in?
		return (not (session[:user_id].nil? or get_user.nil?))
	end
	
	def require_login
		if session[:user_id].nil?
			redirect_to '/auth/login'
		else
			user = get_user
			if user.nil?
				flash[:notice] = "This email is not authorized"
				session[:user_id] = nil
				redirect_to '/auth/login'
			end
		end
	end
	
	def get_user
		user_id = session[:user_id]
		user = Ca.get_by_user_id(user_id)
		if user.nil?
			user = Admin.get_by_user_id(user_id)
		end
		return user
	end

end