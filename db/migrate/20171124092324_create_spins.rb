class CreateSpins < ActiveRecord::Migration[5.1]
  def change
    create_table :spins do |t|
      t.integer :status
      t.string :title
      t.text :summary

      t.timestamps
    end
  end
end
