class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :content, null: false
      t.belongs_to :user, null: false
      t.belongs_to :spin, null: false
      t.belongs_to :section
      t.integer :position, default: 1, null: false
      t.timestamps
    end
  end
end
