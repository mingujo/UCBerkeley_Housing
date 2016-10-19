class SchedulerMailer < ApplicationMailer
    default from: 'mingu08@berkeley.edu'

    def email_notification(guy_CA)
        @guy_CA = guy_CA
        @url  = 'http://ucb_housing.com/spreadsheet'
        mail(to: @guy_CA.email, subject: "Hey ____, You're scheduled on ______")
    end
    
end