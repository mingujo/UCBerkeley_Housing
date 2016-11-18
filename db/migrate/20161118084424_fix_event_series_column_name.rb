class FixEventSeriesColumnName < ActiveRecord::Migration
  def self.up
    rename_column :event_series, :starttime, :start_time
    rename_column :event_series, :endtime, :end_time
  end
end
