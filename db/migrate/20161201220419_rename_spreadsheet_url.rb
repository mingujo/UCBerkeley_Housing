class RenameSpreadsheetUrl < ActiveRecord::Migration
  def change
    rename_column :spreadsheets, :url, :spreadsheet_id
  end
end


