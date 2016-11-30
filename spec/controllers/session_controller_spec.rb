require 'rails_helper'
require 'time'
RSpec.describe SessionsController, type: :controller do
#describe SessionsController do 
  #describe "POST #create" do
  #describe "DELETE #destroy" do how it looks like in events_controller
  
  describe "#destroy" do
    #before do
    #  post :create, provider: :github
    #end
 
    it "should clear the session" do
      session[:user_id].should_not be_nil
      delete :destroy
      session[:user_id].should be_nil
    end
 
    it "should redirect to the home page" do
      delete :destroy
      response.should redirect_to '/auth/login'
    end
  end
end