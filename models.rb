require 'sinatra/activerecord'
require 'pg'

configure :development do
set :database, 'postgresql:rumblr'
end

configure :development do
  set :database, ENV['DATABASE_URL']
end
x 

class User < ActiveRecord::Base
  has_many :posts
end

class Post < ActiveRecord::Base
  belongs_to :user
end