class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts, id: :uuid do |t|
      t.string :title, null: false
      t.integer :status, null: false, default: 0
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.integer :comments_count, null: false, default: 0

      t.timestamps
    end
  end
end
