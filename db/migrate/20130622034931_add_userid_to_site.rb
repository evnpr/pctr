class AddUseridToSite < ActiveRecord::Migration
  def change
    add_column :sites, :user_id, :integer
  end
end
