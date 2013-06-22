class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid
  def self.create_with_omniauth(auth)
      create! do |user|
        user.provider = auth["provider"]
        user.uid = auth["uid"]
        user.name = auth["info"]["name"]
        user.image_url = auth["info"]["image"]
      end
  end
  
  has_many :sites
  has_many :comments
end
