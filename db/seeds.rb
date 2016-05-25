    @matt = User.create(name: "Matt", email: "matt@matt.com", password: "1234")
    @car1 = Car.create(
      make: "Honda",
      car_model: "Civic DX",
      color: "Silver",
      transmission: "Automatic",
      year: 1999,
      miles: 65000,
      user_id: @matt.id
      )
    @car2 = Car.create(
      make: "Maserati",
      car_model: "LX",
      color: "Red",
      transmission: "Automatic",
      year: 1994,
      miles: 24000,
      user_id: @matt.id,
      )
    @oil_change = Maintenance.create(name: "Oil Change", car_id: @car1.id, user_id: @matt.id, date: "05/22/16", miles: "64,000", description: "changed oil")
    @brake_change = Maintenance.create(name: "Replace Brakes", car_id: @car1.id, user_id: @matt.id, date: "05/23/16", miles: "64,000", description: "replace brakes")
    @tire_rotation = Maintenance.create(name: "Rotate Tires", car_id: @car2.id, user_id: @matt.id, date: "05/24/16", miles: "64,000", description: "rotated tires")
    @wiper_fluid = Maintenance.create(name: "Refill Wiper Fluid", car_id: @car2.id, user_id: @matt.id, date: "05/25/16", miles: "64,000", description: "refilled wiper fluid")