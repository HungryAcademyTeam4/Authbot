require 'bundler'
Sinatra::Application.environment = :test
Bundler.require :default, Sinatra::Application.environment

