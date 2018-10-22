class CreateRecipis < ActiveRecord::Migration[5.2]
  def change
    create_table :recipis do |t|
      t.string :name
      t.text :preparation_description
      t.string :ingredients, array: true
      t.references :owner, foreign_key: { to_table: :users }

      t.timestamps
    end
    add_index :recipis, :name
  end
end
