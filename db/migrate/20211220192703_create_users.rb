class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.integer :role, null: false, default: 1
      t.string :full_name
      t.string :password_digest, null: false
      t.integer :tokens_count, null: false, default: 0
      t.integer :posts_count, null: false, default: 0
      t.integer :comments_count, null: false, default: 0

      t.timestamps
    end
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end
