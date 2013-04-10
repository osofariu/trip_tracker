class AddDatesToTripAndPlaces < ActiveRecord::Migration
  def up
    add_column :trips,  :start_date, :date
    add_column :trips,  :end_date, :date
    add_column :places, :arrival_date, :date
    add_column :places, :days, :integer
  end

  def down
    remove_column :trips,  :start_date
    remove_column :trips,  :end_date
    remove_column :places, :arrival_date
    remove_column :places, :days
  end
end
