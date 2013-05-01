class AddValidationFlagToRoute < ActiveRecord::Migration
  def up
    add_column :routes, :active, :boolean, default: true
  end

  def down
    remove_column :routes, :active
  end
end
