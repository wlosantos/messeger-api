class CreateApps < ActiveRecord::Migration[7.0]
  def change
    create_table :apps do |t|
      t.string :name, null: false
      t.integer :app_id, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
