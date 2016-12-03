class CreateSpreadsheet < ActiveRecord::Migration
  def change
    create_table :spreadsheets do |t|
      t.integer :month
      t.integer :year
      t.string  :url
    end
  end
end
