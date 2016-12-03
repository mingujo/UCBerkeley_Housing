require 'rails_helper'

RSpec.describe SpreadsheetsController, type: :controller do
    
    let(:valid_session) { {} }
      
  before :each do
    @request.session[:user_id] = double()
    allow(Ca).to receive(:get_by_user_id) { |id| double("Ca") }
    # added line
    allow(Admin).to receive(:get_by_user_id) { |id| double("Admin") }
  end
    
    
    
    describe "POST #create" do  
        it "does not create a new Spreadsheet with invalid link" do
            post :create, {:ca => {:link => "invalid_id", :month => 11, :year => 2016}}
            expect(response).to redirect_to(new_spreadsheet_path)
            expect(flash[:error]).to be_present
        end
        
        
        it "does not create a new Spreadsheet with invalid month" do
            valid_spreadsheet_id = "https://docs.google.com/spreadsheets/d/1tIuyylSNMianWOxUQCvHhYQGb8tONDDVyliWQemWwBM/edit#gid=408995429"
            post :create, {:ca => {:link => valid_spreadsheet_id, :month => 13, :year => 2016}}
            expect(response).to redirect_to(new_spreadsheet_path)
            expect(flash[:error]).to be_present
        end
         
         
        it "does not create a new Spreadsheet with invalid year on spreadsheet" do #may take this out later
            valid_spreadsheet_id = "https://docs.google.com/spreadsheets/d/1tIuyylSNMianWOxUQCvHhYQGb8tONDDVyliWQemWwBM/edit#gid=408995429"
            post :create, {:ca => {:link => valid_spreadsheet_id, :month => 11, :year => 666}}
            expect(response).to redirect_to(new_spreadsheet_path)
            expect(flash[:error]).to be_present        

        end
        
        it "creates a new Spreadsheet with valid link, month, and year" do
            allow_any_instance_of(SpreadsheetsController).to receive(:populate_spreadsheet)
            valid_spreadsheet_id = "https://docs.google.com/spreadsheets/d/1tIuyylSNMianWOxUQCvHhYQGb8tONDDVyliWQemWwBM/edit#gid=408995429"
            post :create, {:ca => {:link => valid_spreadsheet_id, :month => 11, :year => 2016}}
            expect(response).to redirect_to(spreadsheets_path)
            expect(flash[:success]).to be_present
        end
    end
end