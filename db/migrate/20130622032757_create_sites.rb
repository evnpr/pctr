class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :title
      t.text :description
      t.string :url

      t.timestamps
    end
  end
end
