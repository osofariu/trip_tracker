class AddSeqNoAndBaseIdToPlace < ActiveRecord::Migration
  def up
    add_column :places, :seq_no, :integer, unique: true, default: 0
    add_column :places, :base_id, :integer
  end
  def down
    remove_column :places, :seq_no
    remove_column :places, :base_id
  end
end
