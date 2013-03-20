class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :activity_type
      t.decimal :cost
      t.string :name
      t.text :notes

      t.timestamps
    end
  end
end
