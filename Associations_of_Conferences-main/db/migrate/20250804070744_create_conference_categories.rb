class CreateConferenceCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :conference_categories do |t|
      t.string :name, null: false
      t.references :conferences, null: false, foreign_key: true
      t.timestamps
    end
  end
end
