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
      erb :'/users/cars/index'
    else
      redirect "/users/#{@current.slug}"
    end
  end

  post '/users/:slug/cars' do
    @user = Helpers.current_user(session)
    @game = Game.create(date: params[:date])
    
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