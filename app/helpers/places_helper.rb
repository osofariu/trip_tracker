module PlacesHelper

 #is this the first place created or the one with smallest seq_no?
  def first_place?(trip, place)
    trip.major_places.count == 0 or (place && place.seq_no == 1)
  end

  def default_arrival_date(prev_place)
    if prev_place && prev_place.days && prev_place.arrival_date
      desired_date=prev_place.arrival_date.next_day(prev_place.days)
    elsif prev_place && prev_place.arrival_date
      desired_date=prev_place.arrival_date
    end
    return {year: desired_date.year, month: desired_date.month, day: desired_date.day} if desired_date
  end

  # manage seq_no for places both globally and for minor place (which are grouped under a major place)
  class PlaceOrderManager
    def account_for(place)
      if !place.id && !place.seq_no                     # new place, didn't specify position: put it at the end
          place.seq_no = get_max_seq_no(place)+1          
      elsif !place.id && place.seq_no                   # new place, specified position: insert at that location
        insert_place(place)
      else                                              # existing place: if seq_no has changed, move it to new location
        existing_place = Place.find(place.id)
        if existing_place.seq_no != place.seq_no
          @places_ref ||= get_places(place)
          move_place(existing_place.seq_no, place)
        end
      end
    end

    # this gets called when you want to insert a place before others
    # this will also be called after a place is removed, to fix the seq_no of the rest
    def update_places(place)
      @places_ref ||= get_places(place)
      Rails.logger.debug "in update_place: ref: #{@places_ref.inspect}"
      @places_ref.each_with_index do |place, index|
        if place[:id]                                    # if this is null it's for a new place which is already in the right order
          db_place = Place.find(place[:id])
          if (index) != db_place.seq_no-1
            db_place.update_column(:seq_no, index+1)
          end
        end
      end
    end

    private
    def get_places(place)
      if place.parent_id
        @places_ref ||= Place.find(place.parent_id).my_minor_places.map {|p| make_places_ref(p)}
      else
        @places_ref ||= Place.where(trip_id: place.trip_id).order('seq_no ASC').map {|p|make_places_ref(p)}
      end
    end

    def make_places_ref(place)                  # only keep track of essential fields
      {id: place.id, seq_no: place.seq_no}
    end
  
    def get_max_seq_no(place)
      if place.parent_id
        Place.where(trip_id: place.trip_id, parent_id: place.parent_id).count
      else
        Place.where(trip_id: place.trip_id, parent_id: nil).count
      end
    end

    def fix_place_seq_no(place, adding_place)
      Rails.logger.debug "place: #{place.inspect} new is #{adding_place}"
      max_seq_no = get_max_seq_no(place)
      if adding_place
        max_seq_no +=1
      end      
      new_seq_no = place.seq_no > max_seq_no ? max_seq_no : place.seq_no 
      if place.seq_no != new_seq_no
          Rails.logger.debug "User attempted to set to_index to #{place.seq_no}, which is larger than max value of #{max_seq_no}"
          place.seq_no = new_seq_no
      end
      Rails.logger.debug "new_seq_no: #{new_seq_no}"
      return new_seq_no
    end

    def insert_place(place)
      fix_place_seq_no(place, true)
      get_places(place).insert(place.seq_no-1, make_places_ref(place))
      update_places(place)
    end

    def move_place(from_index, place)
      fix_place_seq_no(place, false)
      places_ref = get_places(place)
      p_ref = places_ref.delete_at(from_index-1)
      places_ref.insert(place.seq_no-1, p_ref)
      update_places(place)
    end
  end
end
