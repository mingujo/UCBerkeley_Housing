class CreateCas < ActiveRecord::Migration
  def change
    create_table :cas do |t|

      t.timestamps null: false
    end
  end
end
