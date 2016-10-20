require "rails_helper"

describe "get email from name" do
    before do
        Emails.put_email(1, "asdf", "jkl;")
    end
    
    it "gets mapping from name to email" do
        mappings = Emails.get_email_mappings
        expect(mappings["asdf"]).to eq("jkl;")
    end
end