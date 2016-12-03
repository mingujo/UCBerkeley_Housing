require "rails_helper"
require "time"
include TimeslotHelper

RSpec.describe SchedulerMailer, type: :mailer do
    before :all do
        @temp_guy = Ca.create({:id=> 100, 
                               :name=> ENV["TEST_GUY_NAME"], 
                               :email=>ENV["TEST_GUY_EMAIL_ADDR"]})
        starttime = Time.parse('2020-09-01 09:00')
        @temp_ts = Timeslot.create({:id => 123,
                                    :starttime => starttime, 
                                    :endtime => add_30min(starttime),
                                    :ca_id => @temp_guy.id, 
                                    :client_name => 'John',
                                    :phone_number => '510-123-1234',
                                    :apt_number => '123',
                                    :current_tenant => 'Rafael'
	    })
    end
    
    after :all do
        Ca.destroy(@temp_guy.id)
        Timeslot.destroy(@temp_ts.id)
    end
    
    describe "new_schedule_notification_email(guy_CA)" do
        before :all do
            @mail = SchedulerMailer.send_email(@temp_guy.id, @temp_ts.starttime, "new_schedule")
        end

        it "expects email subject" do
            expect(@mail.subject).to eq(ENV["NEW_SCHEDULE_SUBJECT"])
        end
        
        it "sends from the default email" do
            expect(@mail.from[0]).to eq(ENV["GMAIL_USERNAME"])
        end
        
        it "sends to the relevant recipient" do
            expect(@mail.to[0]).to eq(@temp_guy.email)
        end

        it "should send an email" do
            @mail.deliver_now
            expect(ActionMailer::Base.deliveries.count).to eq(1)
        end

    end
    
    describe "cancellation_email(guy_CA)" do
        before :all do
            @mail = SchedulerMailer.send_email(@temp_guy.id, @temp_ts.starttime, "cancellation")
        end

        it "expects email subject" do
            expect(@mail.subject).to eq(ENV["CANCELLATION_SUBJECT"])
        end
        
        it "sends from the default email" do
            expect(@mail.from[0]).to eq(ENV["GMAIL_USERNAME"])
        end
        
        it "sends to the relevant recipient" do
            expect(@mail.to[0]).to eq(@temp_guy.email)
        end

        it "should send an email" do
            @mail.deliver_now
            expect(ActionMailer::Base.deliveries.count).to eq(1)
        end

    end
end

