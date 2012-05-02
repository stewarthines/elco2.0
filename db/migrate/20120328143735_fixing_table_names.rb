class FixingTableNames < ActiveRecord::Migration
  def self.up
  	rename_table(:nowShowing,:nowShowings)
  	rename_table(:upcoming,:upcomings)
  end

  def self.down
  end
end
