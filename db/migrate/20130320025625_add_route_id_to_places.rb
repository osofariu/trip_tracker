class AddRouteIdToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :route_id, :integer
  end
end
