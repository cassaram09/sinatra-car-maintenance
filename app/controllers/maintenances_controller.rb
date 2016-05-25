class MaintenancesController < ApplicationController
  configure do
    set :views, "app/views"
  end

  #GET PAGE FOR NEW MAINTENANCE TASK
  get '/users/:slug/cars/:id/maintenance/new' do
    if Helpers.is_logged_in?(session)
      @user = User.find_by_slug(params[:slug])
      @current = Helpers.current_user(session)
      @car = Car.find_by(id: params[:id])
      if @current.id == @user.id && @user.car_ids.include?(@car.id) 
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
    if Helpers.is_logged_in?(session)
      @user = User.find_by_slug(params[:slug])
      @current = Helpers.current_user(session)
      @car = Car.find_by(id: params[:id])
      if @current.id == @user.id && @user.car_ids.include?(@car.id) 
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
    if Helpers.is_logged_in?(session)
      @user = User.find_by_slug(params[:slug])
      @current = Helpers.current_user(session)
      @car = Car.find_by(id: params[:captures][1])
      @maintenance = Maintenance.find_by(id: params[:captures][2])
      if @current.id == @user.id && @user.car_ids.include?(@car.id) && @car.maintenance_ids.include?(@maintenance.id)
        erb :'/users/cars/maintenance/edit'
      else
        redirect "/users/#{@current.slug}"
      end
    else
      redirect "/login"
    end
  end

  #GET EDIT PAGE FOR INDIVIDUAL MAINTENANCE TASK
  get '/users/:slug/cars/:id/maintenance/:id/edit' do
    if Helpers.is_logged_in?(session)
      redirect '/users/:slug/cars/:id/maintenance/:id'
    else
      redirect "/login"
    end
  end

  #UPDATE INDIVIDUAL MAINTENANCE TASK
  patch '/users/:slug/cars/:id/maintenance/:id' do
    if Helpers.is_logged_in?(session)
      @user = User.find_by_slug(params[:slug])
      @current = Helpers.current_user(session)
      @car = Car.find_by(id: params[:captures][1])
      @maintenance = Maintenance.find_by(id: params[:captures][2])
      if @current.id == @user.id && @user.car_ids.include?(@car.id) && @car.maintenance_ids.include?(@maintenance.id) 
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
    if Helpers.is_logged_in?(session)
      @user = User.find_by_slug(params[:slug])
      @current = Helpers.current_user(session)
      @car = Car.find_by(id: params[:captures][1])
      @maintenance = Maintenance.find_by(id: params[:captures][2])
      if @current.id == @user.id && @user.car_ids.include?(@car.id) && @car.maintenance_ids.include?(@maintenance.id)
        @maintenance.delete
        redirect "/users/#{@user.slug}/cars/#{@car.id}"
      else
        redirect "/users/#{@current.slug}"
      end
    else
      redirect "/login"
    end
  end

end