require 'rails_helper'

RSpec.describe SpreadsheetsController, type: :controller do
    
    let(:valid_session) { {} }
      
  before :each do
    #@request.session[:user_id] = double()
   # allow(Ca).to receive(:get_by_user_id) { |id| double("Ca") }
    # added line
    #allow(Admin).to receive(:get_by_user_id) { |id| double("Admin") }
  end
    
    
    
    describe "POST #create" do  
        it "does not create a new Spreadsheet with invalid link" do
            post :create, {:ca => {spreadsheet_url => "invalid_id", days_in_month => ""}}
            expect(response).to redirect_to(new_spreadsheet_path)
            expect(flash[:error]).to be_present
        end
        
        
        it "does not create a new Spreadsheet with invalid days in month" do
            valid_spreadsheet_id = "https://docs.google.com/spreadsheets/d/1tIuyylSNMianWOxUQCvHhYQGb8tONDDVyliWQemWwBM/edit#gid=408995429"
            post :create, {:ca => {spreadsheet_url => valid_spreadsheet_id, days_in_month => 1}}
            expect(response).to redirect_to(new_spreadsheet_path)
            expect(flash[:error]).to be_present
        end
         
         
        it "does not create a new Spreadsheet with invalid date on spreadsheet" do #may take this out later
            valid_spreadsheet_id = "https://docs.google.com/spreadsheets/d/1tIuyylSNMianWOxUQCvHhYQGb8tONDDVyliWQemWwBM/edit#gid=408995429"
            post :create, {:ca => {spreadsheet_url => valid_spreadsheet_id, days_in_month => 1}}
            expect(response).to redirect_to(new_spreadsheet_path)
            expect(flash[:error]).to be_present        

        end
        
        it "creates a new Spreadsheet with valid link, date, and days in month" do
            post :create, {:ca => {spreadsheet_url => "invalid_id"}}
            expect(response).to redirect_to(new_spreadsheet_path)
            expect(flash[:success]).to be_present
        end
    end
end