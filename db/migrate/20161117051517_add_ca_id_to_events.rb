class AddCaIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :ca_id, :integer
    add_column :event_series, :ca_id, :integer
    remove_column :events, :title
    remove_column :events, :description
    remove_column :events, :all_day
    remove_column :event_series, :all_day
  end
end
