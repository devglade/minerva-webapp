class CreateSpins < ActiveRecord::Migration[5.1]
  def change
    create_table :spins do |t|
      t.integer :status
      t.string :title, null: false
      t.text :summary, null: false
      t.belongs_to :retrospect, null: false
      t.belongs_to :user, null: false

      t.timestamps
    end
  end
end
