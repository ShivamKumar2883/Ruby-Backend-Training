class CreateBagdes < ActiveRecord::Migration[8.0]
  def change
    create_table :bagdes do |t|
      t.string :badge_type, null: false
      t.string :badge_name, null: false
      t.timestamps
    end
  end
end
