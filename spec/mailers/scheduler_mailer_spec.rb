require "rails_helper"

RSpec.describe SchedulerMailer, type: :mailer do
    describe "email_notification(guy_CA)" do
        before :each do
            @temp_guy = double("CA", :name=> "Sora", :email=>"testing@gmail.com")
            @mail = SchedulerMailer.email_notification(@temp_guy)
        end

        it "expects email subject" do
            expect(@mail.subject).to eq("Hey ____, You're scheduled on ______")
        end
        
        it "sends from the default email" do
            expect(@mail.from[0]).to eq("mingu08@berkeley.edu")
        end
        
        it "sends to the given recipient" do
            expect(@mail.to[0]).to eq(@temp_guy.email)
        end

        # it "expects the number of mails sent to increment by 1" do
        #     expect(SchedulerMailer.deliver_now).to change { ActionMailer::Base.deliveries.count }.by(1)
        # end
    end
end

# expect {custom_mailer.deliver}.to change { ActionMailer::Base.deliveries.count }.by(1)
