class CreateMailDeliveries < ActiveRecord::Migration
  def change
    create_table :mail_deliveries do |t|
      t.string :day
      t.integer :to_id
      t.integer :from_id
      t.decimal :weight
      t.decimal :size
      t.string :priority

      t.timestamps null: false
    end
  end
end
