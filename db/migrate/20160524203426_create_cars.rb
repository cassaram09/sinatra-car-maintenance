class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :make
      t.string :car_model
      t.string :color
      t.string :transmission
      t.integer :year
      t.string :miles
      t.belongs_to :user
    end
  end
end
