class CreateSpaces < ActiveRecord::Migration[5.1]
  def change
    create_table :spaces do |t|
      t.string :name
      t.string :url
      t.boolean :is_public
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
