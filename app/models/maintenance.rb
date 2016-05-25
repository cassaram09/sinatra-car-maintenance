class Maintenance < ActiveRecord::Base

  belongs_to :car
  belongs_to :user

  @@base_maintenance = ["Air Filter", "Oil/Oil Filter", "Windshield Wipers / Fluid", "Battery", "Headlights", "Brake Pads", "Fuel Filter", "Spark Plugs", "Radiator Flush", "Fuses"]

  def self.select_user_maintenance(user)
    user_maintenance = []
    self.all.each do |maintenance|
      if maintenance.user_id == user.id
        user_maintenance << maintenance.name
      end
    end
    maintenance = @@base_maintenance + user_maintenance.uniq
  end
end

