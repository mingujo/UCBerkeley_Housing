class CreateTimeslot1s < ActiveRecord::Migration
  def change
    create_table :timeslot1s do |t|
      t.string :time
      t.integer :CA_id
      t.string :client_name
      t.string :phone_number
      t.string :apt_number
      t.string :current_tenant

      t.timestamps null: false
    end
  end
  
  def destroy
    drop_table :timeslot1s
  end
end
