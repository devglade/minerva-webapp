class CreateRetrospects < ActiveRecord::Migration[5.1]
  def change
    create_table :retrospects do |t|
      t.string :title, limit: 500, null: false
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
