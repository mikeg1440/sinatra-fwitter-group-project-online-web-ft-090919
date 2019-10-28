class UsersController < ApplicationController

  get '/login' do
    redirect '/tweets' if is_logged_in?

    erb :'users/login'
  end

  post '/login' do
    # add user_id to the session hash
    if is_logged_in?
      redirect '/tweets'
    else
      @user = User.find_by(username: params[:username])
      if @user && @user.authenticate(params[:password])

        response.set_cookie(:user_id, @user.id)
        session[:user_id] = @user.id
        redirect '/tweets'
      else
        redirect '/login'
      end
    end
  end


  get '/users/:username' do
    @user = User.find_by(params)
    @tweets = @user.tweets
    # redirect '/tweets'
    erb :'/tweets/index'
  end


  get '/signup' do

    if is_logged_in?
      redirect '/tweets'
    end

    erb :'/users/signup'
  end

  post '/signup' do
    @user = User.create(params)
    session[:user_id] = @user.id
    if @user.errors.any?
      redirect '/signup'
    else
      redirect '/tweets'
    end
  end

  get '/logout' do
    session.clear
    response.delete_cookie("user_id")
    # request.cookies.clear
    redirect '/login'
  end

end
