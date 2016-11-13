require 'time'

class RenameTimeColumn < ActiveRecord::Migration
  def change
    rename_column :timeslots, :time, :starttime
    add_column :timeslots, :endtime, :string
  end

end
