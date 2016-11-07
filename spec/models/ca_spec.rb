# require 'rails_helper'

# RSpec.describe Ca, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

require 'rails_helper'

RSpec.describe Ca, type: :model do
	subject { described_class.new }
	it "is valid with valid attributes" do
		    subject.name = "Anything"
		    subject.email = "aaaa@berkeley.edu"
		    subject.phone_number = "510-365-6555"
		    expect(subject).to be_valid
	end
  	
end

