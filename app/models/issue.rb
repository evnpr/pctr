class Issue < ActiveRecord::Base
  attr_accessible :name, :user_id
  belongs_to :user
  has_many :issuesites
  has_many :sites, :through => :issuesites
  has_many :komentars, :dependent => :destroy
  has_many :users, :through => :komentars
end
