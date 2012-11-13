class ChangeRankColumnToZeroDefault < ActiveRecord::Migration
  def up
  	change_column :users, :negative_rank, :integer, :default => 0
  	change_column :users, :positive_rank, :integer, :default => 0
  	change_column :users, :title, :text, :default => ''
  end

  def down
  end
end
