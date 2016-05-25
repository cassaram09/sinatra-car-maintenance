class MaintenancesController < ApplicationController
  configure do
    set :views, "app/views"
  end

  get '/users/:slug/maintenance' do
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    if @current.id == @user.id
      erb :'/users/show_maintenance'
    else
      redirect "/users/#{@current.slug}"
    end
  end

  get '/users/:slug/maintenance/delete' do
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    if @current.id == @user.id
      erb :'/users/delete_maintenance'
    else
      redirect "/users/#{@current.slug}"
    end
  end

  delete '/users/:slug/maintenance/delete' do
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    if @current.id == @user.id
      Task.find_by(name: params[:task]).delete
      redirect "/users/#{@current.slug}/maintenance"
    else
      redirect "/users/#{@current.slug}"
    end
  end

  patch '/users/:slug/maintenance/edit' do
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    if @current.id == @user.id
      params[:task].each do |task|
        task_object = Task.find_by(id: task[:id])
        task_object.update(name: task[:name])
      end
      redirect "/users/#{@current.slug}/maintenance"
    else
      redirect "/users/#{@current.slug}"
    end
  end

  post '/users/:slug/maintenance/new' do
    binding.pry
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    if @current.id == @user.id
      Task.create(name: params[:task])
      redirect "/users/#{@current.slug}/maintenance"
    else
      redirect "/users/#{@current.slug}"
    end
  end

  get '/users/:slug/cars/:id/maintenance/new' do
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    if @current.id == @user.id
      @car = Car.find_by(id: params[:id])
      erb :'/users/cars/maintenance/new'
    else
      redirect "/users/#{@current.slug}"
    end
  end

  post '/users/:slug/cars/:id/maintenance/' do
    @user = Helpers.current_user(session)
    @car = Car.find_by(id: params[:id])
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