class CreateLocations < ActiveRecord::Migration[8.0]
  def change
    create_table :locations do |t|
      t.string :address, null: false
      t.string :city, null: false
      t.string :pincode, null: false
      t.references :state, null: false, foreign_key: true
      t.references :district, null: false, foreign_key: true
      t.timestamps
    end
  end
end