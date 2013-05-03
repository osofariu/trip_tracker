require 'spec_helper'

describe TripsHelper do
  describe 'get_trips' do
    it "returns empty list when user has no trips" do
      helper.get_trips.should == ([])
    end

    it "returns a list with one trip when user has one trip" do
      trip = create(:trip)
      session[:user_id] = trip.user_id
      puts "session.inspect: #{session.inspect}"
      helper.get_trips.should == [trip]
    end
  end
end