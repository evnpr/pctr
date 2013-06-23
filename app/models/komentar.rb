class Komentar < ActiveRecord::Base
  attr_accessible :bermutu, :biasa, :gakmutu, :issue_id, :message, :user_id
  belongs_to :issue
  belongs_to :user
end
