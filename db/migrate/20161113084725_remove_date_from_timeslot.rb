class RemoveDateFromTimeslot < ActiveRecord::Migration
  def change
    remove_column :timeslots, :date, :date
    change_column :timeslots, :starttime, :datetime
    change_column :timeslots, :endtime, :datetime
  end
end
