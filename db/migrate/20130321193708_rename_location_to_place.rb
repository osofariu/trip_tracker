class RenameLocationToPlace < ActiveRecord::Migration
  def up
    rename_column :routes, :start_location, :start_place
    rename_column :routes, :end_location, :end_place
  end

  def down
  end
end
