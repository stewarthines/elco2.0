require 'rubygems'
require 'sinatra'
require 'sinatra/activerecord'
# require 'sinatra/base'
require './partials.rb'
require './auth.rb'
require 'digest/sha1'
# require 'rack-flash'

enable :sessions


helpers Sinatra::Partials
helpers Sinatra::Authorization

# class MyApp < Sinatra::Base
#   enable :sessions
#   use Rack::Flash

#   post '/set-flash' do
#     # Set a flash entry
#     flash[:notice] = "Thanks for signing up!"

#     # Get a flash entry
#     flash[:notice] # => "Thanks for signing up!"

#     # Set a flash entry for only the current request
#     flash.now[:notice] = "Thanks for signing up!"
#   end
# end


# Creating classes for our stored database entities
# This allows us to use this as active record entities, savind and retrieving from the db
class Movie < ActiveRecord::Base
	has_one :now_showing, :dependent => :destroy
	has_one :upcoming, :dependent => :destroy
end

not_found do
	erb :error
end

class NowShowing < ActiveRecord::Base
	belongs_to :movie
end

class Upcoming < ActiveRecord::Base
	belongs_to :movie
end

get '/login' do
	erb :login
end

post "/login" do
	if login(params[:username], params[:password])
		redirect "/dashboard"
	end	
	redirect "/login"
end

get "/logout" do
	logout
	flash[:notice] = "you logged out!"
	redirect "/"
end 
# def authenticate! 
# 	return false
# end

get "/help" do
	erb :help
end

get '/dashboard' do
	protected!
	erb :dashboard
end

# before '/dashboard' do
# 	unless authenticate!
# 		redirect '/login'
# 	end
# end


#get main page
get '/ ?' do
	erb :index
end



get '/movies' do
	protected!
	erb :movies
end

# This is the add movie page
get '/add_movie' do
	protected!
	erb :add_movie
end



# This is the add movie action, where the form data from /add_movie is posted
post '/add_movie' do
	#create a new movie from the posted data (it is a hash)
	movie = Movie.new(params[:movie])

	#save the newly created movie into the database.
	movie.save

	#respond with some test text so that we can tell it worked
	redirect '/movies'
end

get '/remove_movie/:id' do	
	Movie.destroy(params[:id])
	redirect '/movies'
end

#test for retreiving a movie by id
get '/movie/:id' do

	#retrieve a movie from the database by its id
	movie = Movie.find(params[:id])

	#return text for viewing this test.
	"Title: " + movie.Title
end

#getting the form for adding a new NowShowing
get '/add_now_showing' do
	protected!	
	erb :add_now_showing
end

# This is the add now showing action, where the form data from /add_now_showing is posted
post '/add_now_showing' do
	
	#get the post data into an easier variable
	postData = params[:nowShowing]

	#create an empty now showing object.
	nowShowing = NowShowing.new()
	
	#assign post data to actual object.
	nowShowing.Dates = postData[:Dates]

	#retrieve the movie by its id, and put it into the now showing.
	nowShowing.movie = Movie.find(postData[:Movie])

	#save new record
	nowShowing.save

	redirect '/add_now_showing'
end

get '/remove_now_showing/:id' do
	NowShowing.destroy(params[:id])
	redirect '/add_now_showing'
end

#getting the form for adding a new upcoming
get '/add_upcoming' do	
	erb :add_upcoming
end

# This is the add upcoming action, where the form data from /add_upcoming is posted
post '/add_upcoming' do
	
	#get the post data into an easier variable
	postData = params[:upcoming]

	#create an empty upcoming object.
	upcoming = Upcoming.new()
	
	#assign values from post data into actual object
	# upcoming.Dates = postData[:Dates]

	#retrieve the movie by the id and put it into the upcoming.
	upcoming.movie = Movie.find(postData[:Movie])

	#save the created upcoming record
	upcoming.save

	#respond with some test text so that we can tell it worked
	redirect '/add_upcoming'
end

get '/remove_upcoming/:id' do
	Upcoming.destroy(params[:id])
	redirect '/add_upcoming'
end
