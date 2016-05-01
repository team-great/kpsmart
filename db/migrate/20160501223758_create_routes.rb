class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.integer :to_id
      t.integer :from_id
      t.integer :pirority
      t.string :provider
      t.decimal :weight_cost
      t.decimal :volume_cost
      t.decimal :max_weight
      t.decimal :max_volume
      t.decimal :duration
      t.integer :frequency
      t.string :day

      t.timestamps null: false
    end
  end
end
