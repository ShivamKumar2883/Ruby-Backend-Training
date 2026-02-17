class CreateConferenceModes < ActiveRecord::Migration[8.0]
  def change
    create_table :conference_modes do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
