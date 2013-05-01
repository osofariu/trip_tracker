require 'spec_helper'

describe Place do
  let (:trip) {create(:trip)}

  context "no other place exists," do

    it "can be instantiated" do
      Place.new.should be_an_instance_of(Place)
    end

    it "can be saved successfully," do
      place = build(:place)
      res=place.save
      assert_equal res, true
    end
  end

  context "working with two places create only," do

    it "can have place inserted afterwards, and seq_no does not change" do
      place1 = create(:place, trip: trip)
      place2 = create(:place, trip: trip)
      place1.seq_no.should == 1
    end

    it "can be added as the second place, and seq_no is 1" do
      place1 = create(:place, trip: trip)
      place2 = create(:place, trip: trip)
      place2.seq_no.should == 2
    end

    it "changes its seq_no after another place gets inserted before it" do
      place1 = create(:place, trip: trip)
      place1.seq_no.should == 1
      place2 = create(:place, trip: trip, seq_no: 1)
      place1 = Place.find(place1.id)                    #indirectly changed
      place1.seq_no.should == 2
    end

    it "can be inserted as the first place (before another) and seq_no is 1" do
       place1 = create(:place, trip: trip)
       place2 = create(:place, trip: trip, seq_no: 1)
       place2.seq_no.should == 1
    end
  end

  context "working with three places, create only," do

    it "changes its seq_no after another place gets inserted before the place before it (place2)" do
      place1 = create(:place, trip: trip)
      place2 = create(:place, trip: trip)
      place2.seq_no.should == 2
      place3 = create(:place, trip: trip, seq_no: 1)
      place2 = Place.find(place2.id) #indirectly changed
      place2.seq_no.should == 3
    end

    it "will not change its seq_no if p2 and p3 get added with seq_no in reverse order" do
      place1 = create(:place, trip: trip)
      place1.seq_no.should == 1
      place2 = create(:place, trip: trip)
      place3 = create(:place, trip: trip, seq_no: 2)
      place1 = Place.find(place1.id)
      place1.seq_no.should == 1
    end

    it "should be the second major place (seq_no=1) when added after one major place and its minor place" do
      place1 = create(:place, trip: trip)
      place2 = create(:place, trip: trip, parent_id: place1.id)
      place3 = create(:place, trip: trip)
      place3.seq_no.should == 2
    end

    it "will not change its seq_no if a minor place gets created under previous place" do
       place1 = create(:place, trip: trip)
       place2 = create(:place, trip: trip)
       place2.seq_no.should == 2
       place3 = create(:place, trip: trip, parent_id: place1.id)
       place2 = Place.find(place2.id)
       place2.seq_no.should == 2
    end

    it "as new place, should not allow user to set the seq_no to more than the largest seq_no+1" do
      place1 = create(:place, trip: trip)
      place2 = create(:place, trip: trip, seq_no: 3)
      place2 = Place.find(place2.id) # changed indirectly
      place2.seq_no.should == 2
    end

    it "as an existing place, should not allow user to set the seq_no to more than the largest seq_no" do
      place1 = create(:place, trip: trip)
      place2 = create(:place, trip: trip)
      place2.seq_no.should == 2
      place2.seq_no=3
      place2.save
      place2 = Place.find(place2.id)
      place2.seq_no.should == 2
    end
  end

  context "working with inactive places," do
    context "setting places to inactive" do
      it "is active by default" do
        place1 = create(:place, trip: trip)
        place1.active.should == true
      end

      it "becomes inactive when marked as such" do
        place1 = build(:place, trip: trip)
        place1.active=false
        place1.save
        place1.active.should == false
      end
     
      it "will not get its seq_no decremented by 1 if the place before was marked as inactive" do
        place1 = create(:place, trip: trip)
        place2 = create(:place, trip: trip)
        place1.active=false
        place1.save
        place2.seq_no.should == 2
      end
    end

    context "deleting inactive places," do
      it "will decrement seq_no when place before gets removed" do
        place1 = create(:place, trip: trip, active:false)
        place2 = create(:place, trip: trip)
        Place.remove_trip_inactive_places(trip.id)
        place2 = Place.find(place2.id)
        place2.seq_no.should == 1
        Place.count.should == 1
      end  

      it "will NOT decrement seq_no when place after gets removed" do
        place1 = create(:place, trip: trip)
        place2 = create(:place, trip: trip)
        place2.destroy
        place1.seq_no.should == 1
        Place.count.should == 1
      end
    end

    context "minor places are inactivated when their parent does," do

      it "(as first minor place), gets inactivated" do
        place1 = create(:place, trip: trip)
        place2 = create(:place, trip: trip, parent_id: place1.id)
        place2.active.should == true
        place1.active = false
        place1.save
        place2 = Place.find(place2.id)  #changed indirectly
        place2.active.should == false
      end

      it "(as second minor place), gets inactivated" do
        place1 = create(:place, trip: trip)
        place2 = create(:place, trip: trip, parent_id: place1.id)
        place3 = create(:place, trip: trip, parent_id: place1.id)
        place3.active.should == true
        place1.active = false
        place1.save
        place3 = Place.find(place3.id)  #changed indirectly
        place3.active.should == false
      end
    end

    context "minor places are removed when their parent does," do

      it "(as first minor place), gets removed" do
        place1    = create(:place, trip: trip)
        place1_1  = create(:place, trip: trip, parent_id: place1.id)
        place1.destroy
        expect {
          Place.find(place1_1.id)
        }.to raise_error(/Couldn't find Place/)
      end

      it "(as second minor place), gets removed" do
        place1    = create(:place, trip: trip)
        place1_1  = create(:place, trip: trip, parent_id: place1.id)
        place1_2  = create(:place, trip: trip, parent_id: place1.id)
        place1.destroy
        expect {
          Place.find(place1_2.id)
        }.to raise_error(/Couldn't find Place/)
      end
    end

    context "minor places order," do

      it "gets its own seq_no independent of the parent" do
        place1 = create(:place, trip: trip)
        place2 = create(:place, trip: trip, parent_id: place1.id)
        place2.seq_no.should == 1
      end

      it "gets seq_no of 1 as the second minor place" do
        place1    = create(:place, trip: trip)
        place2    = create(:place, trip: trip)
        place2_1  = create(:place, trip: trip, parent_id: place1.id)
        place2_2  = create(:place, trip: trip, parent_id: place1.id)
        place2_1.seq_no.should == 1
        place2_2.seq_no.should == 2
      end

      it "gets seq_no of 0 as minor place when the minor place before it is removed" do
        place1    = create(:place, trip: trip)
        place1_1  = create(:place, trip: trip, parent_id: place1.id)
        place1_2  = create(:place, trip: trip, parent_id: place1.id)
        place1_2.seq_no.should == 2
        place1_1.destroy
        place1_2 = Place.find(place1_2.id)  # changed indirectly
        place1_2.seq_no.should == 1
      end

      it "does not get moved when parent is moved up (before previous place)" do
        place1 = create(:place, trip: trip)
        place2 = create(:place, trip: trip)
        place3 = create(:place, trip: trip, parent_id: place1.id)
        place3.seq_no.should == 1
        place2.seq_no = 1
        place2.save
        place3 = Place.find(place3.id)
        place3.seq_no.should == 1
      end
    end
  end
end
