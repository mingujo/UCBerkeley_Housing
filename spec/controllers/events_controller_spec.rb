require 'rails_helper'
require 'time'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe EventsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Event. As you add validations to Event, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {:ca_id => "1", :start_time => Time.now, :end_time => Time.now+30.minutes}
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }
  
  let(:valid_session) { {} }
  
  before :each do
    @request.session[:user_id] = double()
    allow(Ca).to receive(:get_by_user_id) { |id| double("Ca") }
    # added line
    #allow(Admin).to receive(:get_by_user_id) { |id| double("Admin") }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # EventsController. Be sure to keep this updated too.

  describe "GET #index" do
    "index method doesnt do anything"
  end
  
  describe "GET #get_events" do
    it "gets all events" do
      event1 = FactoryGirl.create(:event, :ca_id => 1)
      get :get_events, start: "1477810800", end: "1481443200"
      expect(assigns(:events)).to include(event1)
    end
  end


  describe "GET #new" do
    before :each do
      @temp_ca = double("Ca", :id => 3)  
      expect(Ca).to receive(:find).with("3").and_return(@temp_ca)
    end 
    
    it "renders new template" do
        get :new, {:ca_id => 3}
        expect(response).to render_template("events/_form")
    end   
  end

  describe "GET #edit" do
    it "renders edit template" do
        get :edit, {:id => '7'}
        expect(response).to render_template("events/_edit_form")
    end    
  end
  
  describe "POST #move" do
    it "moves an event to one day before" do
        post :move, {:id => '7', :day_delta => '-1'}
        changed_event = Event.find(7)
        changed_ts = Timeslot.find(7)
        expect(changed_event.start_time).to eq(Time.parse("2016-11-23 15:00:00"))
        expect(changed_event.end_time).to eq(Time.parse("2016-11-23 15:30:00"))
        expect(changed_ts.starttime).to eq(Time.parse("2016-11-23 15:00:00"))
        expect(changed_ts.endtime).to eq(Time.parse("2016-11-23 15:30:00"))
    end    
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Event" do
        expect {
          post :create, {:event => {
          'start_time(1i)' => 2016, 
          'start_time(2i)' => 11,
          'start_time(3i)' => 15, 
          'start_time(4i)' => 8, 
          'start_time(5i)' => 0,
          'end_time(1i)' =>2016, 
          'end_time(2i)' =>11, 
          'end_time(3i)' =>15, 
          'end_time(4i)' =>9, 
          'end_time(5i)' =>0,
          :id => 10,
          :ca_id => 5,
          :period => "Does not repeat"}
          }
        }.to change(Event, :count).by(2)
      end

      it "attempts to create an existing Event" do
        expect {
          post :create, {:event => {
          'start_time(1i)' => 2016, 
          'start_time(2i)' => 11,
          'start_time(3i)' => 24, 
          'start_time(4i)' => 9, 
          'start_time(5i)' => 0,
          'end_time(1i)' =>2016, 
          'end_time(2i)' =>11, 
          'end_time(3i)' =>24, 
          'end_time(4i)' =>9, 
          'end_time(5i)' =>30,
          :id => 10,
          :ca_id => 5,
          :period => "Does not repeat"}
          }
        }.to change(Event, :count).by(0)
      end
      
      it "creates a new Event with start time is larger than end time" do
        expect {
          post :create, {:event => {
          'start_time(1i)' => 2016, 
          'start_time(2i)' => 11,
          'start_time(3i)' => 15, 
          'start_time(4i)' => 9, 
          'start_time(5i)' => 0,
          'end_time(1i)' =>2016, 
          'end_time(2i)' =>11, 
          'end_time(3i)' =>15, 
          'end_time(4i)' =>9, 
          'end_time(5i)' =>0,
          :id => 10,
          :ca_id => 5,
          :period => "Does not repeat"}
          }
        }.to change(Event, :count).by(0)
      end
      
      it "creates a new event series" do
        expect {
          post :create, {:event => {
            'start_time(1i)' => 2016, 
            'start_time(2i)' => 11,
            'start_time(3i)' => 11, 
            'start_time(4i)' => 10, 
            'start_time(5i)' => 0,
            'end_time(1i)' =>2016, 
            'end_time(2i)' =>11, 
            'end_time(3i)' =>11, 
            'end_time(4i)' =>10, 
            'end_time(5i)' =>30,
            :id => 2,
            :ca_id => 5,
            :period => 'Weekly',
            :frequency => 3
          }}
          }.to change(EventSeries, :count).by(1)
      end
    end
  end
     
  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested event" do
        event = Event.find(2)
        put :update, id: event.to_param, event: {
                                                  'start_time(1i)' => 2016, 
                                                  'start_time(2i)' => 11,
                                                  'start_time(3i)' => 16, 
                                                  'start_time(4i)' => 10, 
                                                  'start_time(5i)' => 0,
                                                  'end_time(1i)' =>2016, 
                                                  'end_time(2i)' =>11, 
                                                  'end_time(3i)' =>16, 
                                                  'end_time(4i)' =>10, 
                                                  'end_time(5i)' =>30,
                                                }
        event.reload
        expect(assigns(:event).start_time).to eq("2016-11-16 10:00:00")
      end

    end
    
    context "with invalid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested event" do
        event = Event.find(2)
        put :update, id: event.to_param, event: {
                                                  'start_time(1i)' => 2016, 
                                                  'start_time(2i)' => 11,
                                                  'start_time(3i)' => 16, 
                                                  'start_time(4i)' => 10, 
                                                  'start_time(5i)' => 0,
                                                  'end_time(1i)' =>2016, 
                                                  'end_time(2i)' =>11, 
                                                  'end_time(3i)' =>16, 
                                                  'end_time(4i)' =>10, 
                                                  'end_time(5i)' =>00,
                                                }
        event.reload
        expect(event.start_time).to eq("2016-11-24 09:00:00")
      end

    end
    
    context "an Event Series not event" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested event" do
        event = Event.find(8)
        put :update, id: event.to_param, event: {
                                                  'start_time(1i)' => 2016, 
                                                  'start_time(2i)' => 11,
                                                  'start_time(3i)' => 16, 
                                                  'start_time(4i)' => 12, 
                                                  'start_time(5i)' => 0,
                                                  'end_time(1i)' =>2016, 
                                                  'end_time(2i)' =>11, 
                                                  'end_time(3i)' =>16, 
                                                  'end_time(4i)' =>12, 
                                                  'end_time(5i)' =>30,
                                                  :commit_button => "Update All Occurrence"
                                                }
        event.reload
        expect(Event.find(8).start_time).to eq("2016-11-01 12:00:00")
        expect(Event.find(9).start_time).to eq("2016-11-08 12:00:00")
        expect(Timeslot.find(8).starttime).to eq("2016-11-01 12:00:00")
        expect(Timeslot.find(9).starttime).to eq("2016-11-08 12:00:00")
      end

    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested event" do
      expect {
        delete :destroy, {:id => '7'}
      }.to change(Event.all, :count).by(-1).and change(Timeslot.all, :count).by(-1)
    end
    
    it "destroys the requested event series" do
      expect {
        delete :destroy, {:id => '8', :delete_all => "true"}
      }.to change(Event.all, :count).by(-2).and change(Timeslot.all, :count).by(-2)
    end
  end
  

end
