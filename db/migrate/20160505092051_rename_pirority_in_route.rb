class RenamePirorityInRoute < ActiveRecord::Migration
  def change
    rename_column :routes, :pirority, :priority
  end
end
