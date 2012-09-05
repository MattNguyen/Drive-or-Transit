require 'fakeweb'
require 'simplecov'
require_relative '../lib/trip.rb'
require_relative '../lib/user.rb'
require_relative '../lib/address.rb'
require_relative '../lib/brain.rb'
require_relative '../db/database_setup.rb'
SimpleCov.start
FakeWeb.allow_net_connect = false

def driving
  File.read('./spec/api_mocks/driving.json')
end

def transit
  File.read('./spec/api_mocks/transit.json')
end

def walking
  File.read('./spec/api_mocks/walking.json')
end
