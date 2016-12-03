class AddLinkToSpreadsheet < ActiveRecord::Migration
  def change
    add_column :spreadsheets, :link, :string
  end
end
