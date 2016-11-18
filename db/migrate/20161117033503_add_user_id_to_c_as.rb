class AddUserIdToCAs < ActiveRecord::Migration
  def change
    add_column "cas", "user_id", :string
  end
end
