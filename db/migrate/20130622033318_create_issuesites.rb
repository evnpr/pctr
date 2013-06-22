class CreateIssuesites < ActiveRecord::Migration
  def change
    create_table :issuesites do |t|
      t.integer :site_id
      t.integer :issue_id

      t.timestamps
    end
  end
end
