require 'rails_helper'

RSpec.describe Timeslot, type: :model do
	subject { described_class.new }
	it "is valid with valid attributes" do
		    subject.starttime = DateTime.now
		    subject.endtime = DateTime.now
		    subject.ca_id = 1
		    subject.client_name = "Anything"
		    subject.phone_number = "Anything"
		    subject.apt_number = "Anything"
		    subject.current_tenant = "Anything"
		    expect(subject).to be_valid
	end
  	
end
