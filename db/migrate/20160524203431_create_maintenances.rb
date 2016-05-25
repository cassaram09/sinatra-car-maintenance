class CreateMaintenances < ActiveRecord::Migration
  def change
    create_table :maintenances do |t|
      t.string :name
      t.string :date
      t.string :miles
      t.belongs_to :car
      t.belongs_to :user
    end
  end
end
