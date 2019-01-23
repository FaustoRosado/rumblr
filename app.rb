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


