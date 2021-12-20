class CreateTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :tokens, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
