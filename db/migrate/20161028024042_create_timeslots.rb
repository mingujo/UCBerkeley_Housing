class CreateTimeslots < ActiveRecord::Migration
  def change
    create_table :timeslots do |t|
      t.date :date
      t.string :time
      t.references :ca
      t.string :client_name
      t.string :phone_number
      t.string :apt_number
      t.string :current_tenant

      t.timestamps null: false
    end
  end
end
