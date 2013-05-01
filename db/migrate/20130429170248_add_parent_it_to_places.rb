class AddParentItToPlaces < ActiveRecord::Migration
  def up
    add_column :places, :parent_id, :integer
  end

  def down
    remove_column :places, :parent_id
  end
end
