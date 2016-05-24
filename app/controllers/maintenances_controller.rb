class MaintenancesController < ApplicationController
  configure do
    set :views, "app/views"
  end

  get '/users/:slug/cars/:id/maintenance/new' do
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    if @current.id == @user.id
      @car = Car.find_by(params[:id])
      erb :'/users/cars/maintenance/new'
    else
      redirect "/users/#{@current.slug}"
    end
  end

  post '/users/:slug/cars/:id/maintenance/' do
    binding.pry
    @user = Helpers.current_user(session)
    @car = Car.find_by(params[:id])
    @maintenance = Maintenance.create(params[:maintenance])
    @maintenance.update(car_id: @car.id)
    redirect "/users/#{@user.slug}/cars/#{@car.id}"
  end

  get '/users/:slug/cars/:id/maintenance/:id' do
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    if @current.id = @user.id
      @car = Car.find_by(id: params[:captures][1])
      @maintenance = Maintenance.find_by(id: params[:captures][2])
      erb :'/users/cars/maintenance/edit'
    else
      redirect "/users/#{@current.slug}"
    end
  end

  patch '/users/:slug/cars/:id/maintenance/:id' do
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    @car = Car.find_by(id: params[:captures][1])
      @maintenance = Maintenance.find_by(id: params[:captures][2])
    @maintenance.update(params[:maintenance])
    redirect "/users/#{@user.slug}/cars/#{@car.id}"
  end

  delete '/users/:slug/cars/:id/maintenance/:id/delete' do
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    @car = Car.find_by(id: params[:captures][1])
    @maintenance = Maintenance.find_by(id: params[:captures][2])
    @maintenance.delete
    redirect "/users/#{@user.slug}/cars/#{@car.id}"
  end

end