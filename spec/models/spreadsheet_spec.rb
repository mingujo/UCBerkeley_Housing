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
		    subject.spreadsheet_id = "spreadsheet_id"
		    subject.link = "spreadsheet_link"
	end
	
	
	describe "public class methods" do
        context "executes methods correctly" do
            context "self.get_id_by_date" do
                it "given a month and date, return spreadsheet ID" do
                    month = 1
                    year = 2016
                    spreadsheet = FactoryGirl.create(:spreadsheet)
                    expect(Spreadsheet.get_id_by_date(month, year)).to eq("spreadsheet_id")
                end
            end
            
            context "self.get_template_sheet" do
                it "gets the template spreadsheet" do
                    template = FactoryGirl.create(:spreadsheet, :month => 0, :year => 0)
                    expect(Spreadsheet.get_template_sheet).to eq(template)
                end
            end
        end
    end

  	
end