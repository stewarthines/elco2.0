class CreateMovies < ActiveRecord::Migration
  def self.up
  	create_table :movies do |t|
  		t.string :Title
  		t.string :Rating
  		t.string :Starring
  		t.string :RunTime
  		t.text :Description
  		t.string :Trailer_url
  		t.string :IMDB_url
  		t.string :Reviews_url
  		t.string :Poster_url
  	end
  end

  def self.down
  end
end
