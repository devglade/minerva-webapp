class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :title, limit: 500, null: false
      t.text :description
      t.belongs_to :user
      t.belongs_to :space

      t.timestamps
    end
  end
end
