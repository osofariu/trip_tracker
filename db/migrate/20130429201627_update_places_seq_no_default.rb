class UpdatePlacesSeqNoDefault < ActiveRecord::Migration
  def up
    change_column :places, :seq_no, :integer, default: nil
  end

  def down
    change_column :places, :seq_no, :integer, default: 0
  end
end
