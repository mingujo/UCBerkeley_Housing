class CreateEventSeries < ActiveRecord::Migration
  def self.up
    create_table :event_series do |t|
      t.integer :frequency, :default => 1
      t.string :period, :default => 'weekly'
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :all_day, :default => false

      t.timestamps
    end
    
  end

  def self.down
    drop_table :event_series
  end
end
