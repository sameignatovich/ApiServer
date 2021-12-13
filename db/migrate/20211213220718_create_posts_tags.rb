class CreatePostsTags < ActiveRecord::Migration[6.1]
  def change
    create_table :posts_tags, id: :uuid do |t|
      t.references :post, null: false, foreign_key: true, type: :uuid
      t.references :tag, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
