class AddVoteToVote < ActiveRecord::Migration
  def change
    add_column :votes, :vote, :string
  end
end
