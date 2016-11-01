require 'byebug'

class SchedulerMailer < ApplicationMailer
    default from: ENV["GMAIL_USERNAME"]
    
    def new_schedule_notification_email(ca_id)
        @guy_CA = Ca.find_by_id(ca_id)
        @url  = ENV["APP_URL"]
        @timeslot = Timeslot.find_by_ca_id(ca_id)
        mail(to: @guy_CA.email, subject: ENV["NEW_SCHEDULE_SUBJECT"])
        @timeslot.update({:new_schedule_email_sent => true})
    end
    
    def cancellation_email(ca_id)
        @guy_CA = Ca.find_by_id(ca_id)
        @url  = ENV["APP_URL"]
        @timeslot = Timeslot.find_by_ca_id(ca_id)
        mail(to: @guy_CA.email, subject: ENV["CANCELLATION_SUBJECT"])
        @timeslot.update({:cancellation_sent => true})
    end
    
end