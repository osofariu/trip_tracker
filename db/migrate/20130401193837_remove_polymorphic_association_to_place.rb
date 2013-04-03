class RemovePolymorphicAssociationToPlace < ActiveRecord::Migration
  def up
    remove_column :places, :place_ref_id
    remove_column :places, :place_ref_type
  end

  def down
    add_column :places, :place_ref_id, :integer
    add_column :places, :place_ref_type, :string
  end
end
