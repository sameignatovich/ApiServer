class AddColumnsInTokens < ActiveRecord::Migration[7.0]
  def change
    change_table :tokens do |t|
      t.string :device, after: :active
      t.string :os
      t.string :browser
      t.inet :ip
    end
  end
end
