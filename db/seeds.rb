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
      make: "Ford",
      car_model: "Probe",
      color: "Red",
      transmission: "Automatic",
      year: 1994,
      miles: 24000,
      user_id: @matt.id,
      )
    @oil_change = Maintenance.create(name: "Oil Change", car_id: @car1.id, user_id: @matt.id)
    @brake_change = Maintenance.create(name: "Replace Brakes", car_id: @car1.id, user_id: @matt.id)
    @tire_rotation = Maintenance.create(name: "Rotate Tires", car_id: @car2.id, user_id: @matt.id)
    @wiper_fluid = Maintenance.create(name: "Refill Wiper Fluid", car_id: @car2.id, user_id: @matt.id)
    @clean = Maintenance.create(name: "Clean")
    @tire_air = Maintenance.create(name: "Add Tire Air")