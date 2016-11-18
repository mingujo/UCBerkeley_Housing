require 'rails_helper'
require 'time'

# Specs in this file have access to a helper object that includes
# the CalendarHelper. For example:
#
# describe CalendarHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe TimeslotHelper, type: :helper do
	describe "add_30min(time)" do
		it "add 30minutes to the given time" do
			start_time = Time.parse("2016-11-5 12:00:00")
			end_time = Time.parse("2016-11-5 12:30:00")
			expect(add_30min(start_time)).to eq(end_time)
		end
		
		it "returns null if nil argument given" do
			expect(add_30min(nil)).to be_nil	
		end
	end
end
