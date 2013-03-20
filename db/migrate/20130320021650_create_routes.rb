class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.integer :trip_id
      t.integer :start_location
      t.integer :end_location
      t.text :notes
      t.integer :distance

      t.timestamps
    end
  end
end
