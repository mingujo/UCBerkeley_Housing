class AddSentBooleanToTimeslots < ActiveRecord::Migration
  def change
    add_column :timeslots, :new_schedule_email_sent, :boolean, :default => false
    add_column :timeslots, :cancellation_sent, :boolean, :default => false
  end
end
