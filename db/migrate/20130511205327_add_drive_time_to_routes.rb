class AddDriveTimeToRoutes < ActiveRecord::Migration
  def up
    add_column :routes, :drive_time, :string
  end

  def down
    remove_column :routes, :drive_time
  end
end
