class RemoveNameFromWayplace < ActiveRecord::Migration
  def up
    remove_column :way_places, :name
  end

  def down
  end
end
