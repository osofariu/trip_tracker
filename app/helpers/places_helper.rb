module PlacesHelper

  def get_route_segment(place_id)
    segments = []
    start_segment = nil
    end_segment = nil
    WayPlace.where(place_id: place_id).each do |wp|
      if wp.place_kind == "start_place"
        start_segment = "START route: #{wp.get_route_name}"
      elsif wp.place_kind == "end_place"
        end_segment = "END of route: #{wp.get_route_name}"
      else
        segments << "ON route: #{wp.get_route_name}"
      end
    end
    segments.unshift(start_segment)
    segments.append(end_segment)
    return segments
  end

  def get_place_name(place_id)
    Place.find(place_id).name
  end
end
