class CarsController < ApplicationController
  configure do
    set :views, "app/views"
  end

  get '/users/:slug/cars/new' do
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    if @current.id == @user.id
      erb :'/users/cars/new'
    else
      redirect "/users/#{@current.slug}"
    end
  end

  get '/users/:slug/cars/:id' do
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    if @current.id = @user.id
      @car = Car.find_by(id: params[:id])
      erb :'/users/cars/show'
    else
      redirect "/users/#{@current.slug}"
    end
  end

  post '/users/:slug/cars' do
    binding.pry
    @user = Helpers.current_user(session)
    @car = Car.create(params[:car])
    @car.update(user_id: @user.id)
    redirect "/users/#{@user.slug}/cars/#{@car.id}"
  end

  get '/users/:slug/cars/:id' do
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    if @current.id = @user.id
      @game = Game.find_by(id: params[:id])
      erb :'/users/cars/show'
    else
      redirect "/users/#{@current.slug}"
    end
  end

  get '/users/:slug/cars/:id/edit' do
    @user = User.find_by_slug(params[:slug])
    @current = Helpers.current_user(session)
    
  end

  patch '/users/:slug/cars/:id/' do
    #edit game
  end

  delete '/users/cars/:id/delete' do
    #delete game
  end

end