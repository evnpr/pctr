class Issuesite < ActiveRecord::Base
  attr_accessible :issue_id, :site_id
  belongs_to :issue
  belongs_to :site
end
