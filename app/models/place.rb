class Place < ActiveRecord::Base
  attr_accessible :name, :notes, :place_type, :trip_id, :seq_no, :base_id, :arrival_date, :days
  has_many :way_places
  has_many :routes, through: :way_places
  has_many :activities, dependent: :destroy
  has_many :child_places, class_name: "Place", foreign_key: "base_id"
  belongs_to :trip

  validates :name, :trip_id, presence: true
  validates :name, uniqueness: true
  before_save  :init_seq_no

  def init_seq_no
    if self.seq_no.nil? or self.seq_no == 0
      self[:seq_no] = 1 + trip.places.count
    else
      self[:seq_no] = set_and_compact_seq_no(self)
    end
  end


  def first_place?
    if Place.count == 0 or Place.minimum(:seq_no) == seq_no
      true
    else
      false
    end
  end

  def self.get_by_id (id)
    place = Place.find(id)
  end

  def get_activities
    Activity.where(place_id: id)
  end

  private

# TODO : move from using base_place to places, and integate that with UI

  # seq_no must be kept unique, and ordered from 1 to N
  # assumption: places may have one or more duplicate id's (as seq_no); if seq_no is empty, the order is unspecified
  def set_and_compact_seq_no(place)
    trip = Trip.find(place.trip_id)
    places_seq = trip.base_places.order('seq_no ASC').collect {|place| [place.id, place.seq_no]}
    max_seq_no = place.id == nil ? trip.places.count+1 : trip.places.count
    desired_seq_no = place.seq_no <= max_seq_no ? place.seq_no : max_seq_no   # don't let seq_no get out of bounds
    current_seq_no = 0
    if place.id != nil
      places_seq.each do |id_seq|                                             # the value of place.seq_no from the database
        if id_seq[0] == place.id
          current_seq_no=id_seq[1] 
        end
      end
    end
    if (place.id == nil)                                                      # add placeholder for new place at end of sequence
      places_seq.insert(desired_seq_no-1, [place.id, place.seq_no])
    elsif current_seq_no != place.seq_no                                      # move existing place in sequence to where it should be
      r = places_seq.delete_at(current_seq_no-1)
      places_seq.insert(desired_seq_no-1, r)
    end
    expect_id=1
    places_seq.each do |ids|                                                  # all places (including new one) are where they should be in sequence
      if ids[0] == nil or ids[0] == place.id
      elsif ids[1] != expect_id
        p=Place.find(ids[0])
        p.update_column(:seq_no, expect_id)
      end
      expect_id += 1
    end
    return desired_seq_no
  end
end
