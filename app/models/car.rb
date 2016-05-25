class Car < ActiveRecord::Base

  belongs_to :user
  has_many :maintenances, dependent: :delete_all

  def destroy_maintenances
    self.maintenances.delete_all   
  end

  after_destroy :destroy_maintenances

end