module RoutesHelper
  def route_name_rt (route_id)
    route = Route.find(route_id)
    start_place_name = route.start_place ? route.start_place.name : "Unassigned"
    end_place_name   = route.end_place   ? route.end_place.name   : "Unassigned"
    return "#{start_place_name} to #{end_place_name}"
  end
end
