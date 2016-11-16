class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title
      t.datetime :starttime
      t.datetime :endtime
      t.datetime :created_at
      t.datetime :updated_at
      t.text     :description
    end
  end
  
  def self.down
    drop_table :events
  end
end
