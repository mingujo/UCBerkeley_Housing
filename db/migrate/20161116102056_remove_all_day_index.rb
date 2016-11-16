class RemoveAllDayIndex < ActiveRecord::Migration
  def self.down
    remove_index(:events, :name => 'all_day')
  end
end
