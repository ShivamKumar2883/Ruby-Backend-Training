class CreateConferenceComponents < ActiveRecord::Migration[8.0]
  def change
    create_table :conference_components do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
