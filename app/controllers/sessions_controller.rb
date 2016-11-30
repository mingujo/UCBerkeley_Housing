include SessionsHelper

class SessionsController < ApplicationController
    def create
        auth_hash = request.env['omniauth.auth']
        email = auth_hash[:info][:email]
        user = Ca.get_by_email(email)
        is_ca = true
        if user.nil?
            is_ca = false
            user = Admin.get_by_email(email)
        end
        if user
            user.user_id = auth_hash[:uid]
            session[:user_id] = auth_hash[:uid]
            user.save
            if is_ca
                redirect_to ca_path(user.id)
            else
                redirect_to cas_path
            end
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