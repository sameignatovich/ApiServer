class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.integer :role, null: false, default: 1
      t.string :phone, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :address, null: false
      t.string :password_digest, null: false
      t.integer :tokens_count
      t.integer :posts_count
      t.integer :comments_count

      t.timestamps
    end
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end
