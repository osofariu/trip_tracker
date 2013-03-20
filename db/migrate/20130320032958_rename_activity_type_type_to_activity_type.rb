class RenameActivityTypeTypeToActivityType < ActiveRecord::Migration
  def up
    rename_column :activity_types, :type, :activity_type
  end

  def down
  end
end
