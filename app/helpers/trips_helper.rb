module TripsHelper

  def get_trip_name(id)
    Trip.find(id).name
  end

  def get_trips
    if get_user
      return Trip.where(user_id: get_user)
    else
      return []
    end
  end
end
