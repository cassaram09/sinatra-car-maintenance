require 'spec_helper'

describe "Models" do
  before do
    @matt = User.create(name: "Matt", email: "matt@matt.com", password: "1234")
    @car1 = Car.create(
      make: "Honda",
      model: "Civic DX",
      color: "Silver",
      transmission: "Automatic",
      year: 1999,
      miles: 65000,
      user_id: @matt.id
      )
    @car2 = Car.create(
      make: "Ford",
      model: "Probe",
      color: "Red",
      transmission: "Automatic",
      year: 1994,
      miles: 24000,
      user_id: @matt.id,
      )
    @oil_change = Maintenance.create(name: "Oil Change")
    @brake_change = Maintenance.create(name: "Replace Brakes")
    @tire_rotation = Maintenance.create(name: "Rotate Tires")
    @wiper_fluid = Maintenance.create(name: "Refill Wiper Fluid")
    @clean = Maintenance.create(name: "Clean")
    @tire_air = Maintenance.create(name: "Add Tire Air")

  end

  after do
    User.destroy_all
    Car.destroy_all
    Maintenance.destroy_all
  end

  it "allows you to assign cars to users" do
    @matt.cars << @car1
    expect(@matt.cars).to include(@car1)
  end

  it "allows you to assign maintenances to cars" do
    @car1.maintenances << @oil_change
    expect(@car1.maintenances).to include(@oil_change)
  end

  it "allows you to update maintenances on cars" do
    @car1.maintenances << @oil_change
    @car1.maintenances.first.update(date: "5/29/16")
    expect(@car1.maintenances.first.date).to eq("5/29/16")
  end

 
end