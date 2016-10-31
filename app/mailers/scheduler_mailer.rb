require 'byebug'

class SchedulerMailer < ApplicationMailer
    default from: 'mingu08@berkeley.edu' # env var
    # @new_schedule_subject = 'Your new open house schedule!'
    # @cancellation_subject = 'Someone just cancelled open house schedule!'
    @url  = 'http://ucb_housing.com/spreadsheet'
    
    def new_schedule_notification_email(ca_id)
        @guy_CA = Ca.find_by_id(ca_id)
        @timeslot = Timeslot.find_by_ca_id(ca_id)
        mail(to: @guy_CA.email, subject: 'Your new open house schedule!')
        @timeslot.update({:new_schedule_email_sent => true})
    end
    
    def cancellation_email(ca_id)
        @guy_CA = Ca.find_by_id(ca_id)
        @timeslot = Timeslot.find_by_ca_id(ca_id)
        mail(to: @guy_CA.email, subject: 'Someone just cancelled open house schedule!')
        @timeslot.update({:cancellation_sent => true})
    end
    
end