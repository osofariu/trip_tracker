class RemovePlaceTypeFromPlaces < ActiveRecord::Migration
  def up
    remove_column :places, :place_type
  end

  def down
    add_column :places, :place_type, :string, default: 'major'
  end
end
