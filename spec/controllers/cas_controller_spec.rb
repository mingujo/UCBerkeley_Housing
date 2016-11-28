# require 'rails_helper'

# RSpec.describe CasController, type: :controller do
# 	let(:valid_attributes) {
# 	{:ca_id => "1", :start_time => Time.now, :end_time => Time.now+1.hour}
# 	}
	
# 	let(:invalid_attributes) {
# 	skip("Add a hash of attributes invalid for your model")
# 	}
	
# 	let(:valid_session) { {} }
	
# 	describe "GET #get_ca_events" do
# 		it "gets all events belonging to a particular CA" do
# 			event1 = FactoryGirl.create(:event, :ca_id => 1)
# 			event2 = FactoryGirl.create(:event, :ca_id => 2)
# 			event3 = FactoryGirl.create(:event, :ca_id => 2)
# 			get :get_ca_events, :ca_id => 2, start: "1477810800", end: "1481443200"
# 			expect(assigns(:events)).to include(event2)
# 			expect(assigns(:events)).to include(event3)
# 			expect(assigns(:events)).not_to include(event1)
# 		end
# 	end
# end