class AddPlaceTypeToPlaceRemoveBaseId < ActiveRecord::Migration
  def up
    add_column    :places, :place_type, :string, default: 'major'
    remove_column :places, :base_id
  end

  def down
    add_column    :places, :base_id, :integer
    remove_column :places, :place_type
  end
end
