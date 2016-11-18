require 'rails_helper'

RSpec.describe Event, type: :model do
	subject { described_class.new }
	it "is valid with valid attributes" do
		    subject.start_time = DateTime.now
		    subject.end_time = DateTime.now
		    subject.ca_id = 1
		    subject.event_series_id = 1
		    expect(subject).to be_valid
	end
  	
end
