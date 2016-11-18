class RemoveDateFromTimeslot < ActiveRecord::Migration
  def change
    remove_column :timeslots, :date, :date
    remove_column :timeslots, :starttime
    remove_column :timeslots, :endtime
    add_column :timeslots, :starttime, :datetime
    add_column :timeslots, :endtime, :datetime
  end
end
