class WayPlace < ActiveRecord::Base
  attr_accessible  :place_id, :route_id, :route_name
  validates :place_id, :route_id, presence: true
  validates :place_id, uniqueness: true

  def route_name
    from=Place.find(Route.find(route_id).start_place).name
    to=Place.find(Route.find(route_id).end_place).name
    return "#{from} to #{to}"
  end

    def cost_of_activities
    cost = 0
    Activity.where(place_id: self.place_id).each do |act|
      cost += act.cost
    end
    return cost
  end
end
