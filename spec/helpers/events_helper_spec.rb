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

RSpec.describe EventsHelper, type: :helper do
	describe "make_event_json" do
		it "makes json files with certain events of Tony (CA) and check if events have right infos" do
			lst_of_jsons = make_event_json(Event.all, ca_id=Ca.find_by_name("Tony").id)
			expect(lst_of_jsons.length).to eq(3)
			expect(lst_of_jsons[0][:client_name]).to eq("James")
			expect(lst_of_jsons[0][:phone_number]).to eq("510-123-1234")
			expect(lst_of_jsons[0][:apt_number]).to eq("301")
			expect(lst_of_jsons[0][:current_tenant]).to eq("George")
			expect(lst_of_jsons[1][:client_name]).to be_nil
			expect(lst_of_jsons[2][:client_name]).to be_nil
		end
		
		it "makes json with whole events for certain ca when there is no ca specified" do
			lst_of_jsons = make_event_json(Event.all)
			expect(lst_of_jsons.length).to eq(4)
			expect(lst_of_jsons[0][:ca_name]).to eq("Tony")
			expect(lst_of_jsons[1][:ca_name]).to eq("Chris")
			expect(lst_of_jsons[2][:ca_name]).to eq("Tony")
			expect(lst_of_jsons[3][:ca_name]).to eq("Tony")
		end
	end
end
