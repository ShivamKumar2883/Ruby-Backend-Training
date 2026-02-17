class CreatePointOfContacts < ActiveRecord::Migration[8.0]
  def change
    create_table :point_of_contacts do |t|

      t.references :enquire_type, null: false, foreign_key: true
      t.references :person_detail, null: false, foreign_key: true

      t.timestamps
    end
  end
end
