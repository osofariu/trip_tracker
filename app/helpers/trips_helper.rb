module TripsHelper

  def get_trip_name(id)
    Trip.find(id).name
  end
end
