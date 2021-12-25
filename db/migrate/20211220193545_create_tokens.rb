class CreateTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :tokens, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.boolean :active, default: true
      t.string :device, after: :active
      t.string :os
      t.string :browser
      t.string :browser_version
      t.inet :ip

      t.timestamps
    end
  end
end
