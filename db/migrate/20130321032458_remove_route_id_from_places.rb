class RemoveRouteIdFromPlaces < ActiveRecord::Migration
  def up
    remove_column :places, :route_id
  end

  def down
  end
end
