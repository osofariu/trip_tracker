class AddPlaceIdToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :place_id, :integer
  end
end
