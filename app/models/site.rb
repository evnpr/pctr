class Site < ActiveRecord::Base
  attr_accessible :description, :title, :url, :host, :image_url, :user_id
  has_many :issuesites
  has_many :comments
end
