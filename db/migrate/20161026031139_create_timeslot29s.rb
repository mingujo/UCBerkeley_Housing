class CreateTimeslot29s < ActiveRecord::Migration
  def change
    create_table :timeslot29s do |t|
      t.string :time
      t.integer :CA_id
      t.string :client_name
      t.string :phone_number
      t.string :apt_number
      t.string :current_tenant

      t.timestamps null: false
    end
  end
end
