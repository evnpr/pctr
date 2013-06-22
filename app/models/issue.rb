class Issue < ActiveRecord::Base
  attr_accessible :name, :user_id
  has_many :issuesites
  has_many :sites, :through => :issuesites
end
