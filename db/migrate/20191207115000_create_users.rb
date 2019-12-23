class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :mail
      t.string :password_digest

      t.timestamps
    end
    add_index :users, :mail, unique: true
  end
end
