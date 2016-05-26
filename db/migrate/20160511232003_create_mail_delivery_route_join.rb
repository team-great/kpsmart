class CreateMailDeliveryRouteJoin < ActiveRecord::Migration
  def change
    create_table :mail_deliveries_routes, :id => false do |t|
      t.integer :mail_delivery_id
      t.integer :route_id
    end
  end
end
