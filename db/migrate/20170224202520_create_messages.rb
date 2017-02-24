class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.string :fullname
      t.string :buddyid
      t.references :buddy, foreign_key: true

      t.timestamps
    end
  end
end
