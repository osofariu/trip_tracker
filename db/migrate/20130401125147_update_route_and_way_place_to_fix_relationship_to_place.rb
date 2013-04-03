class UpdateRouteAndWayPlaceToFixRelationshipToPlace < ActiveRecord::Migration
  def up
    add_column :way_places, :place_kind, :string
    up_update_route_wayplace_relationships
    up_update_route_place_relationships
    remove_column :routes, :start_place
    remove_column :routes, :end_place
  end

  def down
    add_column :routes, :start_place, :integer
    add_column :routes, :end_place, :integer
    down_update_route_place_relationships
    remove_column :way_places, :place_kind
  end

# place_kind: way_place=1; start_place=2 end_place=3
# fixed model to use sybols instead.

  def up_update_route_wayplace_relationships
    ct=0
    WayPlace.all.each do |wp|
      wp.place_kind = :way_place
      wp.save or puts "didn't save #{wp}"
      ct+=1
    end
    puts "updated #{ct} way_places"
  end


  def up_update_route_place_relationships
    ct = 0
    Route.all.each do |route|
      ct += 1
      start_place = Place.find(route.start_place)
      wp_start = WayPlace.new route_id: route.id, place_kind: :start_place, place_id: start_place.id
      wp_start.save or puts "didn't save #{wp_start}"

      end_place = Place.find(route.end_place)
      wp_end = WayPlace.new route_id: route.id, place_kind: :end_place, place_id:  end_place.id
      wp_end.save or puts "didn't save #{wp_end}"
    end
    puts "Updated #{ct} routes, created #{ct*2} way_places"
  end

  def down_update_route_place_relationships
    Route.all.each do |route| 
      WayPlace.where(route_id: route.id, place_kind: :start_place).each do |wp|
        route.start_place = wp.place_id
      end
      WayPlace.where(route_id: route.id, place_kind: :end_place).each do |wp|
        route.end_place = wp.place_id
      end
      route.save or puts "Didn't save #{wp}"
    end
    WayPlace.where(place_id: 2).each do |wp|
      wp.destroy
    end
    WayPlace.where(place_id: 3).each do |wp|
      wp.destroy
    end
  end
end
