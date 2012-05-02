require 'rubygems'
require 'pony'
require 'sinatra'
require '/var/www/elcodrivein.com/web/app.rb'
path = '/var/www/elcodrivein.com/web' # set the root path of your app here. e.g. /var/www/username/somesite

set :root, path
set :views, path + '/views'
set :public, path + '/public'
set :run, false # this line tells mongrel not to run and to let passenger handle the application
set :environment, ENV['RACK_ENV']
set :raise_errors, true

FileUtils.mkdir_p 'logs' unless File.exists?('logs')
log = File.new("logs/sinatra.log", "a")
$stdout.reopen(log)
$stderr.reopen(log)

# always put this line last so that all of your settings are properly loaded before sinatra is booted up
run Sinatra::Application

