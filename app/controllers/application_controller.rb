require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    # set :session_secret, SecureRandom.hex(64)
    set :session_secret, "super-secret-and-long-random-key"
  end

  get '/' do
    erb :'tweets/index'
    # redirect '/tweets'
  end

  get '/failure' do
    erb :fail
  end

  helpers do
    def is_logged_in?

      # !!session[:user_id]
      !!request.cookies["user_id"] || !!session[:user_id]
    end

    def current_user
      # User.find_by_id(session[:user_id])
      if !request.cookies["user_id"]
        session[:user_id]
      else
        User.find_by_id(request.cookies["user_id"])
      end
    end
  end

end
