class RenameSizeToVolumeInMailDelivery < ActiveRecord::Migration
  def change
    rename_column :mail_deliveries, :size, :volume 
  end
end
