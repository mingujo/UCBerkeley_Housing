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
	
	def require_ca_login
		user = Ca.get_by_user_id(session[:user_id])
		unless user.nil?
			if @ca.id != user.id
				flash[:notice] = "You cannot access that user's info"
				redirect_to ca_path(user.id)
			end
		end
	end

	def require_admin_login
		user = Admin.get_by_user_id(session[:user_id])
		if user.nil?
			flash[:notice] = "You must be admin to access that page"
			user = Ca.get_by_user_id(session[:user_id])
			redirect_to ca_path(user.id)
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