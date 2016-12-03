class ChangeSpreadsheetIdToString < ActiveRecord::Migration
  def change
    change_column :spreadsheets, :spreadsheet_id, :string
  end
end
