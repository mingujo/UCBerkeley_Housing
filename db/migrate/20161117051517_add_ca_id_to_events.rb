class AddCaIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :ca_id, :integer
  end
end
