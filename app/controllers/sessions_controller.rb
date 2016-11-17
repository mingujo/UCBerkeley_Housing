class SessionsController < ApplicationController
    def create
        auth_hash = request.env['omniauth.auth']
        email = auth_hash[:info][:email]
        user = Ca.find_by_email(email)
        if user.nil?
            user = Admin.find_by_email(email)
        end
        if user
            user.user_id = auth_hash[:uid]
            session[:user_id] = auth_hash[:uid]
            user.save
            redirect_to '/'
        else
            flash[:notice] = "This email is not authorized"
            redirect_to '/auth/login'
        end
    end
    
    def destroy
        session[:user_id] = nil
        flash[:notice] = 'Logout successful!'
        redirect_to '/'
    end
    
    def login
    end
end