# require 'rails_helper'
# require 'time'
# RSpec.describe SessionsController, type: :controller do
# #describe SessionsController do 
#   #describe "POST #create" do
#   #describe "DELETE #destroy" do how it looks like in events_controller
#   before do
#     request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
#   end
  
#   describe "POST#create" do
 
#     it "should successfully create a user" do
#       expect {
#         post :create, provider: :google_oauth2
#       }.to change{ Admin.count }.by(1)
#     end
 
#     it "should successfully create a session" do
#       session[:user_id].should be_nil
#       post :create, provider: :google_oauth2
#       session[:user_id].should_not be_nil
#     end
 
#     it "should redirect the user to the root url" do
#       post :create, provider: :google_oauth2
#       response.should redirect_to root_url
#     end
 
#   end
  
#   # was in cucumber steps for login
#   # auth_hash = {info: {email: email}, uid: email.hash}
#   # OmniAuth.config.test_mode = true
#   # OmniAuth.config.mock_auth[:google_oauth2] = auth_hash
  
  
#   describe "DELETE#destroy" do
#     before do
#       post :create, provider: :google_oauth2
#     end
 
#     it "should clear the session" do
#       session[:user_id].should_not be_nil
#       delete :destroy
#       session[:user_id].should be_nil
#     end
 
#     it "should redirect to the home page" do
#       delete :destroy
#       flash[:notice].should eql('Logout successful!')
#       response.should redirect_to '/'
#     end
#   end
# end