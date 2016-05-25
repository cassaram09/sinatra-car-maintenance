class CarsController < ApplicationController
  configure do
    set :views, "app/views"
  end

  #GET PAGE FOR NEW CARS
  get '/users/:slug/cars/new' do
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    if @current.id == @user.id
      erb :'/users/cars/new'
    else
      redirect "/users/#{@current.slug}"
    end
  end

  #CREATE NEW CAR
  post '/users/:slug/cars' do
    @user = Helpers.current_user(session)
    @car = Car.create(params[:car])
    @car.update(user_id: @user.id)
    redirect "/users/#{@user.slug}/cars/#{@car.id}"
  end

  #GET INDIVIDUAL CAR PAGE
  get '/users/:slug/cars/:id' do
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    if @current.id == @user.id
      @car = Car.find_by(id: params[:id])
      erb :'/users/cars/show'
    else
      redirect "/users/#{@current.slug}"
    end
  end

  #GET INDIVIDUAL CAR EDIT PAGE
  get '/users/:slug/cars/:id/edit' do
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    @car = Car.find_by(id: params[:id])
    erb :'/users/cars/edit'
  end

  #EDIT INDIVIDUAL CAR
  patch '/users/:slug/cars/:id' do
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    @car = Car.find_by(id: params[:id])
    @car.update(params[:car])
    redirect "/users/#{@user.slug}/cars/#{@car.id}"
  end

  #DELETE INDIVIDUAL CAR
  delete '/users/:slug/cars/:id/delete' do
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    @car = Car.find_by(id: params[:id])
    Car.destroy(@car.id)
    redirect "/users/#{@user.slug}"
  end

end