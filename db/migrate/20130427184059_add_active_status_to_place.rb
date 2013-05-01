class AddActiveStatusToPlace < ActiveRecord::Migration
  def up
    add_column :places, :active, :boolean, default: true
  end

  def down
    remove_column :places, :active
  end
end
