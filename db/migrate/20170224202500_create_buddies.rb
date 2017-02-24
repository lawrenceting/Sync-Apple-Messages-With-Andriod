class CreateBuddies < ActiveRecord::Migration[5.0]
  def change
    create_table :buddies do |t|
      t.string :fullname
      t.string :buddyid

      t.timestamps
    end
  end
end
