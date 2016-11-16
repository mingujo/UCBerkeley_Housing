class AddAllDayToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :all_day, :boolean, :default => false
    add_index :events, :all_day
  end
  
  def self.down
    remove_column :events, :event_series_id
  end
end
