
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

  end

  get '/posts/new' do
    erb :new
  end

  post '/posts' do
    @name = params[:name]
    @content = params[:content]
    Post.create(name: @name, content: @content)
    redirect '/posts'
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  get '/posts/:id' do
    @post = Post.find_by(id: params[:id])
    erb :show
  end

  get '/posts/:id/edit' do
    @id = params[:id]
    @post = Post.find_by(id: @id)
    erb :edit
  end

  patch '/posts/:id' do
    @id = params[:id]
    @name = params[:name]
    @content = params[:content]
    post = Post.find_by(id: @id)
    @post = post.update(name: @name, content: @content)
    erb :show
  end

  delete '/posts/:id/delete' do
    Post.destroy(params[:id])
    redirect "/posts"
  end
end
