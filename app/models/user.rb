class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid
  def self.create_with_omniauth(auth)
      create! do |user|
        user.provider = auth["provider"]
        user.uid = auth["uid"]
        user.name = auth["info"]["name"]
        image_url = auth["info"]["image"]
        image_url.slice! "_normal"
        user.image_url = image_url
      end
  end
  
  has_many :sites
  has_many :comments
end
