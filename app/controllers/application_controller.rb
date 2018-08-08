
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

### CREATE ###

# Renders new.erb view
  get '/posts/new' do
    erb :new
  end

# post blog post, save to database, render index.erb
  post '/posts' do
    @name = params[:name]
    @content = params[:content]
    Post.create(name: @name, content: @content)
    erb :index
  end

### READ ###

# grabs all posts and stores them in @posts
  get '/posts' do
    @posts = Post.all
    erb :index
  end


  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :show
  end

### UPDATE ###
  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    erb :edit
  end

  patch '/posts/:id' do
    @post = Post.find(params[:id])
    @post.name = params[:name]
    @post.content = params[:content]
    @post.save
    redirect "/posts/#{@post.id}" 
  end

  delete '/posts/:id' do
    Post.destroy(params[:id])
    
    redirect '/posts'
  end


end
