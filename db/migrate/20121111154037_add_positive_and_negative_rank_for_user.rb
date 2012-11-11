class AddPositiveAndNegativeRankForUser < ActiveRecord::Migration
  def up
  	add_column :users, :positive_rank, :integer
  	add_column :users, :negative_rank, :integer
  end

  def down
  end
end
