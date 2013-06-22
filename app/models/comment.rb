class Comment < ActiveRecord::Base
  attr_accessible :message, :site_id, :user_id
  belongs_to :user
  belongs_to :site
end
