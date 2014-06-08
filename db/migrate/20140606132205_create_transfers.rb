class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.float :amount
      t.text :message
      t.integer :sender_id
      t.integer :receiver_id
      t.boolean :completed

      t.timestamps
    end
  end
end
