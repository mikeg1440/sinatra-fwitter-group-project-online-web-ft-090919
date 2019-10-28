class TweetsController < ApplicationController

  get '/tweets' do
    if is_logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if is_logged_in?
      @user = current_user
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    params.delete("submit")
    user = current_user
    tweet = Tweet.create(params)
    if tweet.errors.any?
      redirect '/tweets/new'
    else
      user.tweets << tweet
      redirect '/tweets'
    end
  end

  get '/tweets/:id' do
    if is_logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      @user = current_user
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if is_logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    # update the tweet
    if params[:content].empty?
      redirect "/tweets/#{params[:id]}/edit"
    else
      tweet = Tweet.find_by_id(params[:id])
      tweet.update(content: params[:content])
      redirect "/tweets/#{tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find_by_id(params[:id])
    if tweet.user == current_user
      tweet.delete
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

end
