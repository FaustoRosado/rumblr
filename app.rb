require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
# require 'sinatra/reloader'
# to add pagination see paginate gem

# require_relative 'validate'
# require 'will_paginate'
# require 'will_paginate/active_record'

require_relative 'models'

enable :sessions

get '/' do
  begin
    @posts = Post.all
    
  rescue
    @posts = nil
  end

  erb :index
end

post '/' do
  email = params[:email]

  if session[:user_id]
    session[:user_id] = nil

    redirect '/'
  end



  get '/login' do
    erb :login
  end


  get '/signup' do
    erb :signup
  end
  
  post '/signup' do
    email = params[:email]
    password = params[:password]
    # reenter_password = params[:reenter_password]
    firstname = params[:firstname]
    lastname = params[:lastname]
    birthday = params[:birthday]
    @validate = Validate.register(email, password, reenter_password, firstname, lastname, birthday)
  

  end