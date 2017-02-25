class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.string :fullname
      t.string :buddyid
      t.boolean :sent
      t.boolean :received
      t.boolean :delivered
      t.references :buddy, foreign_key: true

      t.timestamps
    end
  end
end
