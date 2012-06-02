require 'bundler'
Bundler.require [:default, :test], Sinatra::Application.environment

Sinatra::Application.environment = :test
