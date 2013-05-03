require 'spec_helper'

describe Route do
  let (:trip) {create(:trip)}

  context "creation of routes" do

    it "should not exist when there's only one place" do
        create(:place, trip: trip)
        trip.routes.should be_empty
    end

    it "should exist as the first route, after the first two places are added" do
      expect {
        p1 = create(:place, trip: trip)
        p2 = create(:place, trip: trip)
        route = Route.where(seq_no: 1).first
        route.start_place.should == p1
        route.end_place.should == p2
      }.to change {Route.all.count}.from(0).to(1)
    end

    it "should exist as the second route between second and third places, after the third place was added" do
      expect {
        p1 = create(:place, trip: trip)
        p2 = create(:place, trip: trip)
        p3 = create(:place, trip: trip)
        route = Route.where(seq_no: 2).first
        route.start_place.should == p2
        route.end_place.should == p3
      }.to change {Route.all.count}.from(0).to(2)
    end 


    it "should exist as the third route between second and third places, after the third place was added" do
      expect {
        p1 = create(:place, trip: trip)
        p2 = create(:place, trip: trip)
        p3 = create(:place, trip: trip)
        p4 = create(:place, trip: trip)
        route = Route.where(seq_no: 3).first
        route.start_place.should == p3
        route.end_place.should == p4
      }.to change {Route.all.count}.from(0).to(3)
    end 

    it "should not be created when adding minor places" do
      expect {
        p1   = create(:place, trip: trip)
        p1_1 = create(:place, trip: trip, parent_id: p1.id)
        p1_2 = create(:place, trip: trip, parent_id: p1.id)
      }.to change{Route.all.count}.by(0)
    end
  end
end