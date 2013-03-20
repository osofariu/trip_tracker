class CreateWayPlaces < ActiveRecord::Migration
  def change
    create_table :way_places do |t|
      t.integer :route_id
      t.integer :place_id
      t.string :name

      t.timestamps
    end
  end
end
