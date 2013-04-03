class AddTripIdToPlaces < ActiveRecord::Migration
  def up
    add_column :places, :trip_id, :integer
    Place.all.each do |p|
      w=WayPlace.where(place_id: p.id)
      if w.length == 0
        puts "Place #{p.id} doesn't belong to any route. Deleting it."
        p.destroy
      else
        trip_id = Route.find(w.first.route_id).trip_id
        puts "Setting p.trip_id to #{trip_id}"
        p.trip_id = trip_id
        puts "FAILED to save trip_id #{trip_id} for place #{p.id}" if !p.save
      end
    end
  end
  def down
    remove_column :places, :trip_id
  end
end
