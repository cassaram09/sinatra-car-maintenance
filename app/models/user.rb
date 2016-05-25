class User < ActiveRecord::Base

  has_secure_password

  has_many :cars

  def destroy_cars
    self.cars.each do |car|
      Car.destroy(car.id) 
    end
  end

  after_destroy :destroy_cars

  def slug
    slug = self.name.strip.downcase.gsub(/[\&\$\+\,\/\:\;\=\?\@\#\s\<\>\[\]\{\}\|\~\^|\%\(\)\*]/, "-").gsub(/\-{2,}/, "-")
  end

  def self.find_by_slug(slug)
    self.all.each do |object|
      name = object.slug
      if name == slug
        return object
      end
    end
  end
  
end