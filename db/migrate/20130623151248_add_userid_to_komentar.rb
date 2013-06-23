class AddUseridToKomentar < ActiveRecord::Migration
  def change
    add_column :komentars, :user_id, :integer
  end
end
