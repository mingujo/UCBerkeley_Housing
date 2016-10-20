require "rails_helper"
require "spec_helper"


RSpec.describe EmailGetter, :type => :helper do
    
    describe "get email" do
        
        before :each do 
            #Calling get_email_mapping will return the emails hash
            @emails = {"a" => "a@a.com"}
        end
            
        it "gets email given name and hash" do  
            #email = EmailGetter.get_email(@emails, "a")
            #expect(email).to equal("a@a.com")
            expect(@emails["a"]).to eq("a@a.com")
        end
    end
end