
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'\
  end

  
  get "/posts/new" do 
    erb :new  
  end 

  post "/posts" do
    Post.create(:name=>params[:name], :content=>params[:content])
    @posts = Post.all

    erb :index
  end 
  
  get "/posts" do
    @posts = Post.all
    
    erb :index
  end
  
  get '/posts/:id' do
    id = params[:id].to_i
    @post = Post.find(id)
    
    erb :show
  end
  
  get '/posts/:id/edit' do
    id = params[:id].to_i
    @post = Post.find(id)
    erb :edit
  end
  
  patch '/posts/:id' do
    @post = Post.find(params[:id].to_i)
    @post.name = params[:name]
    @post.content = params[:content]
    @post.save
    
    erb :update
  end 
  
  delete '/posts/:id/delete' do
    Post.find(params[:id].to_i).destroy
    
    erb :delete
  end
  
end