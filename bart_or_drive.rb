require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, :test)
require_relative 'lib/base'

get '/' do
  @users = Transport::User.all
  haml :index
end
