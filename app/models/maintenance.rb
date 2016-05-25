class Maintenance < ActiveRecord::Base

  belongs_to :car
  belongs_to :user

  def self.select_user_maintenance(user)
    self.all.select do |maintenance|
      maintenance.user_id == user.id
    end
  end
end