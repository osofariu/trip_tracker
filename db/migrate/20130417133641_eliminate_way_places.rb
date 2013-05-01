class EliminateWayPlaces < ActiveRecord::Migration
  def up
    drop_table :way_places
  end

  def down
     create_table :way_places do |t|
      t.integer :route_id
      t.integer :place_id
      t.string  :place_kind

      t.timestamps
    end
  end
end
