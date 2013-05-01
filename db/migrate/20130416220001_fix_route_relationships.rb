class FixRouteRelationships < ActiveRecord::Migration
  def up
    add_column :routes, :start_place_id, :integer
    add_column :routes, :end_place_id, :integer
  end

  def down
    remove_column :routes, :start_place_id
    remove_column :routes, :end_place_id
  end
end
