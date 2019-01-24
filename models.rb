require 'sinatra/activerecord'
require 'pg'

set :database, 'postgresql:rumblr'

class User < ActiveRecord::Base
  has_many :posts
end

class Post < ActiveRecord::Base
  belongs_to :user
end