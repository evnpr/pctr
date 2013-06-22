class AddImageandhostToSite < ActiveRecord::Migration
  def change
    add_column :sites, :image_url, :string
    add_column :sites, :host, :string
  end
end
