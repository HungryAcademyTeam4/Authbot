# Libraries.
require 'rubygems'
require 'bundler/setup'

require 'sqlite3'
require 'sinatra/base'
require 'sinatra-google-auth'
require 'active_record'
require 'sinatra/activerecord'

# Establish the AR connection used by the models.
ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => "db/database.yml"
)

# Models.
require_relative 'user'
