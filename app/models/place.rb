class Place < ActiveRecord::Base
  include PlacesHelper
  include ActionView::Helpers::TextHelper

  attr_accessible :name, :notes, :trip_id, :arrival_date, :days, :after_id, :active, :parent_id, :seq_no

  has_many :activities, dependent: :destroy
  belongs_to :trip

  validates :name, :trip_id, presence: true
  validates_uniqueness_of :name, scope: [:trip_id]

  before_save     :fix_seq_no, :update_my_minor_places_status
  after_save      :fix_routes
  before_destroy  :delete_my_minor_places                       # minor places depend on their parent
  after_destroy   :fix_seq_no_after_destroy, :fix_routes        # removing a place may affect the other of others, and the routes

  public 

  # minor places in between start and end
  def my_minor_places
    return Place.where(trip_id: self.trip_id, parent_id: self.id)
  end

  # cost only at this place/destination
  def cost_of_activities
    Activity.where(place_id: id).each.inject(0) {|sum, activity| sum + activity.cost}
  end

  # this includes this and all minor places that follow it
  def cost_of_activities_at_destination
    total_cost=cost_of_activities # cost at this location
    my_minor_places.each do |place|
      total_cost += place.cost_of_activities
    end
  end

  def self.remove_trip_inactive_places(trip_id)
    trip = Trip.find(trip_id)
    trip.places.where(active: false).each do |place|
      place.destroy
    end
  end

    def showArrivalDate
    if arrival_date
      arrival_date.strftime("%b %-d")
    end 
  end

  def showDuration
    if days
      pluralize(days, "day")
    end
  end

  protected

  def fix_seq_no
    PlaceOrderManager.new.account_for(self)
  end

  def fix_seq_no_after_destroy
    PlaceOrderManager.new.update_places(self)
  end

  def delete_my_minor_places
    my_minor_places.each do |minor_place| 
      minor_place.destroy
    end
  end

  def update_my_minor_places_status
    if self.active_changed?
      my_minor_places.each do |minor_place| 
        minor_place.update_attributes(active: self.active) if (minor_place.active != self.active)
      end
    end
  end

  def fix_routes
    Route.fix_routes(trip_id)
  end

end