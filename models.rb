require 'sinatra/activerecord'
require 'pg'
require_relative 'models'

set :database, 'postgresql:rumblr'