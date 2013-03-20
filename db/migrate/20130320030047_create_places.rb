class CreatePlaces < ActiveRecord::Migration
  def change
    drop_table :places
    create_table :places do |t|
      t.string :name
      t.text :notes
      t.integer :route_id

      t.timestamps
    end
  end
end
