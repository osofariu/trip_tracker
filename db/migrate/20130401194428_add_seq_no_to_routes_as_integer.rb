class AddSeqNoToRoutesAsInteger < ActiveRecord::Migration
  def change
    add_column :routes, :seq_no, :integer
  end
end
