require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra/reloader'
# to add pagination see paginate gem

require_relative 'validate'
require 'will_paginate'
require 'will_paginate/active_record'

require_relative 'models'

enable :sessions

get '/' do
  begin
    @posts = Post.all.order(datetime: :desc).limit(20).offset(params[:page])
    @paginate = Post.paginate(:page => params[:page], :per_page => 20)
  rescue
    @posts = nil
  end

  erb :index
end

post '/' do
  email = params[:email]

  if session[:user_id]
    session[:user_id] = nil
  elsif Validate.login(email, params[:password])
    @user = User.find_by(email: email.downcase)
    session[:user_id] = @user.id
    flash[:info] = "You have successfully logged in, #{@user.firstname}."
  else
    flash[:warning] = 'Invalid username or password.'
  end

  redirect '/'
end

get '/account' do
  if session[:user_id]
    erb :account
  else
    flash[:warning] = 'Sign up to start blogging.'
    redirect '/signup'
  end
end

post '/account/password' do
  current = params[:current]
  new = params[:new]
  new_again = params[:new_again]
  user = User.find(session[:user_id])

  @errors = []

  if current != user.password
    @errors << 'The current password is not correct.'
  end

  if new.length < 6 || new.length > 32
    @errors << 'Your password must be between 6 and 32 characters.'
  end

  if new != new_again
    @errors << 'The new passwords do not match.'
  end

  if @errors.empty?
    user.update(password: new)
    flash[:info] = 'Your password has been successfully updated.'
  else
    flash[:warning] = @errors.join('<br />')
  end

  redirect '/account'
end

delete '/delete_post/:id' do
  Post.find(params[:id]).destroy
  flash[:info] = 'Your post has been deleted.'
  redirect "/user/#{session[:user_id]}/posts"
end

delete '/account' do
  user = User.find(session[:user_id])

  if params[:email] == user.email && params[:password] == user.password
    flash[:info] = 'Your account has been successfully deleted.'
    User.find(session[:user_id]).destroy
    session[:user_id] = nil
    redirect '/'
  else
    flash[:warning] = 'Either your email or password was incorrect.'
    redirect '/account'
  end
end

get '/user/:id' do
  begin
    @user = User.find(params[:id])
    @posts = @user.posts.order(datetime: :desc).limit(20).offset(params[:page])
    @paginate = @posts.paginate(page: params[:page], per_page: 20)
  rescue
    flash[:warning] = 'There are no posts associated with this user!'
    redirect '/'
  end
  erb :posts
end
  
get '/user/:id/posts' do
  begin
    @user = User.find(params[:id])
    @posts = @user.posts.order(datetime: :desc).limit(20).offset(params[:page])
    @paginate = @posts.paginate(:page => params[:page], :per_page => 20)
  rescue
    flash[:warning] = 'This user has no posts!'
    redirect '/'
  end
  erb :posts
end

get '/user/:user_id/posts/:id' do
  begin
    @post = Post.find(params[:id])
    if params[:user_id].to_i == @post.user_id
      erb :show_post
    else
      raise 'error'
    end
  rescue
    flash[:warning] = 'There is no post id associated with this user!'
    redirect "/user/#{params[:user_id]}/posts"
  end
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

  get '/user/posts/new' do
    erb :new_post
  end
  
  post '/posts' do
    title = params[:title]
    validate = Validate.post(title)
    if validate == true
      Post.create(
        title: title,
        content: params[:content],
        user_id: session[:user_id],
        image_url: params[:image_url],
        datetime: Time.now.utc
      )
    else
      flash[:warning] = validate
    end
  
    redirect "/user/#{session[:user_id]}/posts"
  end

  get '/*' do
    erb :pagenotfound
  end