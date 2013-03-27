module PlacesHelper

  def get_route_segment(place_id)
    segments = []
    Route.where(start_place: place_id).each do |rt|
      segments << "START of route: #{rt.route_name}"
    end
    Route.where(end_place: place_id).each do |rt|
      segments << "END of route: #{rt.route_name}"
    end
    WayPlace.where(place_id: place_id).each do |wp|
      segments << "ON route: #{wp.route_name}"
    end
    return segments
  end

  def get_place_name(place_id)
    Place.find(place_id).name
  end
end
