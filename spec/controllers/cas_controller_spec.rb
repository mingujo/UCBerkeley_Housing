require 'rails_helper'

RSpec.describe CasController, type: :controller do
	let(:valid_attributes) {
		{:ca_id => "1", :start_time => Time.now, :end_time => Time.now+1.hour}
	}
	
	let(:invalid_attributes) {
		skip("Add a hash of attributes invalid for your model")
	}
	
	let(:valid_session) { {} }
	
	before :each do
    	@request.session[:user_id] = 100
    	# @request.host = '127.0.0.1:3000'

		ca = double("Ca")
		allow(ca).to receive(:id) { 4 }
    	allow(Ca).to receive(:get_by_user_id) { |id| ca }
    	# allow(Ca).to receive(:id).with(4)

    	# added line
    	allow(Admin).to receive(:get_by_user_id) { |id| double("Admin") }
	end
	
	# describe "GET #get_ca_events" do
	# 	it "gets all events belonging to a particular CA" do
	# 		event1 = FactoryGirl.create(:event, :ca_id => 1)
	# 		event2 = FactoryGirl.create(:event, :ca_id => 2)
	# 		event3 = FactoryGirl.create(:event, :ca_id => 2)
	# 		get :get_ca_events, :ca_id => 2, start: "1477810800", end: "1481443200"
	# 		expect(assigns(:events)).to include(event2)
	# 		expect(assigns(:events)).to include(event3)
	# 		expect(assigns(:events)).not_to include(event1)
	# 	end
	# end
	
# 	describe "GET #index" do
#         ca1 = FactoryGirl.create(:ca_id, :email, :phone_number)
#         expect{get :index}.to change(Ca, :count).by(0)
#     end
    
    describe "GET #new" do
    	it "makes new ca" do
	    	ca1 = FactoryGirl.create(:ca, :name => "Hola", :user_id => "2", :email => "hola@gmail.com", :phone_number => "111-111-1111")
	    	get :new
	    	expect(assigns(:ca)).to be_a_new(Ca)
	    end
	    
	    it "renders new template" do
	        get :new
	        expect(response).to render_template("cas/new")
	    end
    end   

    
    describe "POST #create" do
    	# before :each do
        it "creates a new Event" do
            expect {FactoryGirl.create(:ca)}.to change(Ca, :count).by(1)
        end
        
        # it "redirects to cas_path when ca is saved" do
        # 	FactoryGirl.create(:ca)
        #     post :create 
        #     expect(response).to render_template("cas")
        # end
        
      #  it "redirects and notifies when name and email are not filled out" do
    		# @temp_ca = double("Ca", :id => 2)  
      #  	post :create
      #      expect(flash[:notice]).to eq("Please input your name and email at least")
      #      expect(response).to render_template("cas/new")
      #  end

    end
    
    describe "GET #index" do
    	it "assigns @ca" do
	    	ca1 = FactoryGirl.create(:ca, :name => "Hola", :user_id => "2", :email => "hola@gmail.com", :phone_number => "111-111-1111")
    		get :index
    		expect(assigns(:ca)).to include(ca1)
    	end
    end
    
    
    describe "PUT #update" do
        it "notifies after movie is updated" do
        	# allow(Ca).to receive(:id).and_return(4)
        	ca1 = FactoryGirl.create(:ca)
          	put :update, :id => ca1.id, :ca => {:name => "NewName", :email => "new@email.com"}
            expect(flash[:notice]).to eq("Ca was successfully updated.")
        end
		
		it "gives flash message when name & email are not filled out" do
			ca1 = FactoryGirl.create(:ca)
          	put :update, :id => ca1.id, :ca => {:name => "", :email => ""}
            expect(flash[:error]).to eq("Please input your name and email at least.")
        end
    end
    
    describe "DELETE #destory" do
    	it "destroys the requested event" do

    	  expect {
        	delete :destroy, {:id => Ca.find_by_name("Tony")[:id]}
    	  }.to change(Event.all, :count)

    	end

    end
    
	describe "GET #get_ca_events" do
		it "gets all events of this CA" do
		  event1 = FactoryGirl.create(:event, :ca_id => 1)
		  get :get_ca_events, :ca_id => 1, start: "1477810800", end: "1481443200"
		  expect(assigns(:events)).to include(event1)
		end
	end
end