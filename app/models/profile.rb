class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :shifts

  #validates :bid_line, :presence => true
end
