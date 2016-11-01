
class SchedulerMailer < ApplicationMailer
    default from: ENV["GMAIL_USERNAME"]

    def send_email(ca_id, subject)
        @type = subject
        @timeslot = Timeslot.find_by_ca_id(ca_id)
        if subject == "cancellation"
            subject = ENV["CANCELLATION_SUBJECT"]
            @timeslot.update({:cancellation_sent => true})
        elsif subject == "new_schedule"
            subject = ENV["NEW_SCHEDULE_SUBJECT"]
            @timeslot.update({:new_schedule_email_sent => true})
        end
        @guy_CA = Ca.find_by_id(ca_id)
        @url = ENV["APP_URL"]
        mail(to: @guy_CA.email, subject: subject)
    end
end