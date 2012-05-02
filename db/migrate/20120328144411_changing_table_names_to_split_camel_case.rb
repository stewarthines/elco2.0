class ChangingTableNamesToSplitCamelCase < ActiveRecord::Migration
  def self.up
  	rename_table(:nowShowings, :now_showings)  	
  end

  def self.down
  end
end
