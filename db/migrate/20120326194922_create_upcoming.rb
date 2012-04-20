class CreateUpcoming < ActiveRecord::Migration
  def self.up
  	create_table :upcoming do |t|
  		t.string :Dates
  		t.references :movie
  	end
  end

  def self.down
  end
end
