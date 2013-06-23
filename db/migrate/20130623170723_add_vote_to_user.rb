class AddVoteToUser < ActiveRecord::Migration
  def change
    add_column :users, :biasa, :integer, :default => 0
    add_column :users, :bermutu, :integer, :default => 0
    add_column :users, :gakmutu, :integer, :default => 0
  end
end
