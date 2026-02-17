class CreatePointOfContacts < ActiveRecord::Migration[8.0]
  def change
    create_table :point_of_contacts do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone_number, null: false
      t.references :enquire_type, null: false, foreign_key: true
      t.references :conference, null: false, foreign_key: true
      t.timestamps
    end
  end
end
