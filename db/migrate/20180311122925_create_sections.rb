class CreateSections < ActiveRecord::Migration[5.1]
  def change
    create_table :sections do |t|
      t.string :title, null: false
      t.integer :order, default: 0, null: false
      t.belongs_to :spin, null: false
      t.timestamps null: false
    end
  end
end
