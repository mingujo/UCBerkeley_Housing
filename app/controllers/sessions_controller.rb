class SessionsController < ApplicationController
    def create
        auth_hash = request.env['omniauth.auth']
        email = auth_hash[:info][:email]
        ca = Ca.find_by(email: email)
        if ca
            ca.user_id = auth_hash[:uid]
            session[:user_id] = auth_hash[:uid]
            ca.save
            redirect_to '/'
        elsif is_admin(email)
            session[:user_id] = auth_hash[:uid]
            redirect_to '/'
        else
            flash[:notice] = "This email is not authorized"
            redirect_to '/'
        end
    end
    
    def is_admin(email)
        return false
    end
    
    def destroy
        session[:user_id] = nil
        flash[:notice] = 'Logout successful!'
        redirect_to '/'
    end
end