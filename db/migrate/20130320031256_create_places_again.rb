class CreatePlacesAgain < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.text :notes
      t.integer :route_id

      t.timestamps
    end
  end
end
