class MaintenancesController < ApplicationController
  configure do
    set :views, "app/views"
  end

  #GET PAGE FOR NEW MAINTENANCE TASK
  get '/users/:slug/cars/:id/maintenance/new' do
    if current_user
      @user = User.find_by_slug(params[:slug])
      @car = Car.find_by(id: params[:id])
      if @current_user.id == @user.id && @user.car_ids.include?(@car.id)
        @maintenances = Maintenance.select_user_maintenance(@user)
        erb :'/users/cars/maintenance/new'
      else
        redirect "/users/#{@current.slug}"
      end
    else
      redirect "/login"
    end
  end

  #CREATE NEW MAINTENANCE TASK
  post '/users/:slug/cars/:id/maintenance' do
    if current_user
      @user = User.find_by_slug(params[:slug])
      @car = Car.find_by(id: params[:id])
      if @current_user.id == @user.id && @user.car_ids.include?(@car.id) 
        params[:maintenance].each do |maintenance|
          if maintenance[:name] == "" || maintenance[:date] == "" || maintenance[:miles] == ""
            next
          end
          @maintenance = Maintenance.create(maintenance)
          @maintenance.update(car_id: @car.id, user_id: @user.id)
        end
        redirect "/users/#{@user.slug}/cars/#{@car.id}"
      else
        redirect "/users/#{@current.slug}"
      end
    else
      redirect "/login"
    end
  end

  #GET EDIT PAGE FOR INDIVIDUAL MAINTENANCE TASK
  get '/users/:slug/cars/:id/maintenance/:id' do
    if current_user
      @user = User.find_by_slug(params[:slug])
      @car = Car.find_by(id: params[:captures][1])
      @maintenance = Maintenance.find_by(id: params[:captures][2])
      if valid_user_maintenances
        erb :'/users/cars/maintenance/edit'
      else
        redirect "/users/#{@current.slug}"
      end
    else
      redirect "/login"
    end
  end

  #GET EDIT PAGE FOR INDIVIDUAL MAINTENANCE TASK - REDIRECT
  get '/users/:slug/cars/:id/maintenance/:id/edit' do
    if Helpers.is_logged_in?(session)
      redirect '/users/:slug/cars/:id/maintenance/:id'
    else
      redirect "/login"
    end
  end

  #UPDATE INDIVIDUAL MAINTENANCE TASK
  patch '/users/:slug/cars/:id/maintenance/:id' do
    if current_user
      @user = User.find_by_slug(params[:slug])
      @car = Car.find_by(id: params[:captures][1])
      @maintenance = Maintenance.find_by(id: params[:captures][2])
      if valid_user_maintenances
        if params[:maintenance][:name] == "" || params[:maintenance][:date] == ""
          redirect "/users/#{@user.slug}/cars/#{@car.id}"
        end
        @maintenance.update(params[:maintenance])
        redirect "/users/#{@user.slug}/cars/#{@car.id}"
      else
        redirect "/users/#{@current.slug}"
      end
    else
      redirect "/login"
    end
  end

  #DELETE INDIVIDUAL MAINTENANCE TASK
  delete '/users/:slug/cars/:id/maintenance/:id/delete' do
    if current_user
      @user = User.find_by_slug(params[:slug])
      @car = Car.find_by(id: params[:captures][1])
      @maintenance = Maintenance.find_by(id: params[:captures][2])
      if valid_user_maintenances
        @maintenance.delete
        redirect "/users/#{@user.slug}/cars/#{@car.id}"
      else
        redirect "/users/#{@current.slug}"
      end
    else
      redirect "/login"
    end
  end

  private
    def valid_user_maintenances
      @current_user.id == @user.id && @user.car_ids.include?(@car.id) && @car.maintenance_ids.include?(@maintenance.id)
    end

end