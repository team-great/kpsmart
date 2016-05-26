class AddPricesToRoute < ActiveRecord::Migration
  def change
    add_column :routes, :weight_price, :decimal
    add_column :routes, :volume_price, :decimal
  end
end
