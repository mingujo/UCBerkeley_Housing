class AddCaIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :ca_id, :integer
    add_column :event_series, :ca_id, :integer
    remove_column :events, :title
    remove_column :events, :description
  end
end
