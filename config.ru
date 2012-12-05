# Run this with 'rackup -p 4567'

require 'bundler'
Bundler.require

require 'sinatra'

require './feature_counter_app.rb'

run FeatureCounterApp.new
