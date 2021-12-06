class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts, id: :uuid do |t|
      t.string :title, null: false
      t.text :text, null: false
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.integer :comments_count, null: false, default: 0

      t.timestamps
    end
  end
end
