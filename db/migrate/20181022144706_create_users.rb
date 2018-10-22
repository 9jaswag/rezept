class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :reset_digest
      t.datetime :reset_time
      t.string :activation_digest
      t.boolean :activated
      t.datetime :activated_time
      t.boolean :is_admin, default: false

      t.timestamps
    end
    add_index :users, :username
    add_index :users, :email
  end
end
