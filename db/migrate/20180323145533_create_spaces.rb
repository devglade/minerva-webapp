class CreateSpaces < ActiveRecord::Migration[5.1]
  def change
    create_table :spaces do |t|
      t.string :name, null: false
      t.string :description, null: true
      t.string :url, null: false
      t.boolean :is_public, null: false, default: true
      t.bigint :user_id, null: false
      t.timestamps
    end
  end
end
