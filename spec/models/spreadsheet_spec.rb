require 'rails_helper'

RSpec.describe Spreadsheet, type: :model do
    
    
  it "has a valid factory" do
    # Using the shortened version of FactoryGirl syntax.
    expect(build(:spreadsheet)).to be_valid
  end

  # Lazily loaded to ensure it's only used when it's needed
  let(:factory_instance) { build(:spreadsheet) }
    
    
    
	subject { described_class.new }
	it "is valid with valid attributes" do
		    subject.month = 1
		    subject.year = 2016
		    subject.url = "spreadsheet_id"
		    subject.link = "spreadsheet_link"
	end
	
	
	describe "public class methods" do
        context "executes methods correctly" do
            context "self.get_url_by_date" do
                it "given a month and date, return spreadsheet ID" do
                    month = 1
                    year = 2016
                    spreadsheet = FactoryGirl.create(:spreadsheet)
                    expect(Spreadsheet.get_url_by_date(month, year)).to eq("spreadsheet_id")
                end
            end
        end
    end

  	
end