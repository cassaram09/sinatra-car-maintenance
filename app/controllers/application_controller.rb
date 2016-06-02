require 'sinatra/base'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, "public"
    set :views, "app/views"
    enable :sessions
    set :session_secret, "carmaintenance4days"
  end

  #GET THE HOME PAGE
  get '/' do
    if Helpers.is_logged_in?(session) 
      @user = Helpers.current_user(session)
      redirect "/users/#{@user.slug}"
    else 
      erb :index
    end
  end

  #GET LOGIN PAGE
  get '/login' do
    if Helpers.is_logged_in?(session) 
      @user = Helpers.current_user(session)
      redirect "/users/#{@current.slug}"
    else 
      erb :login
    end
  end

  #SEND LOGIN CREDENTIALS TO DATABASE
  post '/login' do
    if !params.has_value?("") #if any field is blank, throw an error and reload the page
      @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
        session[:id] = @user.id
        flash[:message] = "Welcome, #{@user.name}!"
        redirect "/users/#{@user.slug}"
      else
        flash[:message] = "Incorrect username or password."
        redirect '/login'
      end
    else
      flash[:message] = "Error: Please fill out all fields."
      redirect '/login'
    end
  end

  #GET SIGN UP PAGE
  get '/signup' do
    if Helpers.is_logged_in?(session) 
      @user = Helpers.current_user(session)
      redirect "/users/#{@user.slug}"
    else 
      erb :signup
    end 
  end

  #CREATE NEW USER
  post '/signup' do
    if !params.has_value?("")  #if any field is blank, throw an error and reload the page
      if User.find_by(email: params[:email])
        flash[:message] = "That email is already associated with another account."
        redirect '/signup'
      end
      @user = User.new(params)
      if @user.save
        @user.save
        session[:id] = @user.id
        @session = session
         flash[:message] = "Welcome, #{@user.name}!"
        redirect "/users/#{@user.slug}"
      else
        flash[:message] = "There was an error. Please try again."
        redirect '/signup'
      end
    else
      flash[:message] = "Please fill out all fields."
      redirect '/signup'
    end
  end

  #LOG USER OUT
  get '/logout' do
    session.clear
    redirect '/'
  end

  #REDIRECT USERS IF THEY TRY TO ACCESS THIS PAGE
  get '/users' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session) 
      redirect "/users/#{@user.slug}"
    else 
      redirect '/'
    end 
  end

  #GET USER DASHBOARD IF LOGGED IN 
  get '/users/:slug' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      if @user.slug == params[:slug]
        @user_cars = @user.cars
        erb :'/users/show'
      else
        redirect "/users/#{@user.slug}"
      end
    else
      redirect "/login"
    end
  end


  private
    def current_user
      @current_user = User.find(session[:id])
    end

end