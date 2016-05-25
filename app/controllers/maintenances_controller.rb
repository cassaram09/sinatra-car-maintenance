class MaintenancesController < ApplicationController
  configure do
    set :views, "app/views"
  end

  #GET PAGE FOR NEW MAINTENANCE TASK
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

  #CREATE NEW MAINTENANCE TASK
  post '/users/:slug/cars/:id/maintenance' do
    binding.pry
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    @car = Car.find_by(params[:id])
    if @current.id == @user.id
      params[:maintenance].each do |maintenance|
        @maintenance = Maintenance.create(maintenance)
        @maintenance.update(car_id: @car.id, user_id: @user.id)
      end
      redirect "/users/#{@user.slug}/cars/#{@car.id}"
    else
      redirect "/users/#{@current.slug}"
    end
  end

  #GET PAGE FOR INDIVIDUAL MAINTENANCE TASK
  get '/users/:slug/cars/:id/maintenance/:id' do
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    if @current.id == @user.id
      @car = Car.find_by(id: params[:captures][1])
      @maintenance = Maintenance.find_by(id: params[:captures][2])
      erb :'/users/cars/maintenance/edit'
    else
      redirect "/users/#{@current.slug}"
    end
  end

  #EDIT PAGE FOR INDIVIDUAL MAINTENANCE TASK
  get '/users/:slug/cars/:id/maintenance/:id/edit' do
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    if @current.id == @user.id
      @car = Car.find_by(id: params[:captures][1])
      @maintenance = Maintenance.find_by(id: params[:captures][2])
      erb :'/users/cars/maintenance/edit'
    else
      redirect "/users/#{@current.slug}"
    end
  end

  #UPDATE INDIVIDUAL MAINTENANCE TASK
  patch '/users/:slug/cars/:id/maintenance/:id' do
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    @car = Car.find_by(id: params[:captures][1])
    @maintenance = Maintenance.find_by(id: params[:captures][2])
    @maintenance.update(params[:maintenance])
    redirect "/users/#{@user.slug}/cars/#{@car.id}"
  end

  #DELETE INDIVIDUAL MAINTENANCE TASK
  delete '/users/:slug/cars/:id/maintenance/:id/delete' do
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    @car = Car.find_by(id: params[:captures][1])
    @maintenance = Maintenance.find_by(id: params[:captures][2])
    @maintenance.delete
    redirect "/users/#{@user.slug}/cars/#{@car.id}"
  end

end