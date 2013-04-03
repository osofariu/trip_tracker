class AddPolymorphicAssociationToPlace < ActiveRecord::Migration
  def change
    add_column :places, :place_ref_id, :integer
    add_column :places, :place_ref_type, :string
  end
end
