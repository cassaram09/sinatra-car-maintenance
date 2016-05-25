require 'sinatra/base'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, "public"
    set :views, "app/views"
    enable :sessions
    set :session_secret, "carmaintenance4days"
  end

  #Get the home page
  get '/' do
    if Helpers.is_logged_in?(session) 
      @user = Helpers.current_user(session)
      redirect "/users/#{@user.slug}"
    else 
      erb :index
    end
  end

  #Get the login page
  get '/login' do
    @user = Helpers.current_user(session)
    if Helpers.is_logged_in?(session) 
      redirect "/users/#{@user.slug}"
    else 
      erb :login
    end
  end

  #Send login credentials to database
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

  #Get the sign up page
  get '/register' do
    if Helpers.is_logged_in?(session) 
      @user = Helpers.current_user(session)
      redirect "/users/#{@user.slug}"
    else 
      erb :register
    end 
  end

  #Send signup credentials to database
  post '/register' do
    if !params.has_value?("")  #if any field is blank, throw an error and reload the page
      if User.find_by(email: params[:email])
        flash[:message] = "That email is already associated with another account."
        redirect '/register'
      end
      @user = User.new(params)
      if @user.save
        @user.save
        session[:id] = @user.id
        @session = session
        redirect "/users/#{@user.slug}"
      else
        flash[:message] = "There was an error. Please try again."
        redirect '/register'
      end
    else
      flash[:message] = "Please fill out all fields."
      redirect '/register'
    end
  end

  #Log the user out of the application
  get '/logout' do
    session.clear
    redirect '/'
  end

  #redirect the user if they try to access this page
  get '/users' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session) 
      redirect "/users/#{@user.slug}"
    else 
      redirect '/'
    end 
  end

  #Render the user's dashboard if they're loggedin, otherwise redirect 
  get '/users/:slug' do
    @user = Helpers.current_user(session)
    if Helpers.is_logged_in?(session) && @user.slug == params[:slug]
        @user = Helpers.current_user(session)
        erb :'/users/show'
      else
      redirect "/"
    end
  end

end