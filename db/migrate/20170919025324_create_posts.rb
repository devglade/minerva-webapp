class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :content, null: false
      t.belongs_to :user, null: false
      t.belongs_to :spin, nulll: false
      t.belongs_to :section, null: false
      t.timestamps
    end
  end
end
