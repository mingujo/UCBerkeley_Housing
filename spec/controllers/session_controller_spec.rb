require 'rails_helper'
require 'time'
require 'spec_helper'
RSpec.describe SessionsController, type: :controller do
  before do
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
  end
  
  describe "POST#create" do
    it "should successfully get a user" do
      request.env["omniauth.auth"][:info][:email].should == 'housingnotificationsystem@gmail.com'
    end
      
    describe "for signed in users" do
      it "should successfully create a session" do
        session[:user_id].should be_nil
        post :create, provider: :google_oauth2
        session[:user_id].should_not be_nil
      end
      describe "for admin" do 
        it "should direct the user to cas page" do
          post :create, provider: :google_oauth2
          response.should redirect_to '/cas'
        end
      end
    end
  end
  describe "DELETE#destroy" do
    before do
      post :create, provider: :google_oauth2
    end
 
    it "should clear the session" do
      session[:user_id].should_not be_nil
      delete :destroy
      session[:user_id].should be_nil
    end
 
    it "should redirect to the home page" do
      delete :destroy
      flash[:notice].should eql('Logout successful!')
      response.should redirect_to '/'
    end
  end
end
describe "for nonsigned users" do 
  it 'should redirect to admin user' do
    get :create, :provider => :google_oauth2
    expect(response).to redirect_to('/auth/login')
  end
end