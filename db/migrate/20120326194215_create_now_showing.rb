class CreateNowShowing < ActiveRecord::Migration
  def self.up
  	create_table :nowShowing do |t|
  		t.string :Dates
  		t.references :movie
  	end
  end

  def self.down
  end
end
