class CreateStores < ActiveRecord::Migration[8.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :information
      t.string :location
      t.string :state
      t.string :district

      t.timestamps
    end
  end
end
