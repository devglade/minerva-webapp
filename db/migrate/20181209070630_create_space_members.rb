class CreateSpaceMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :space_members do |t|
      t.belongs_to :space, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
    add_index :space_members, [:user_id, :space_id], unique: true
  end
end
