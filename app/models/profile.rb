class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :shifts, dependent: :destroy

  validates :bid_line, numericality: true, :allow_nil => true
  validate :line_exist, unless: 'bid_line.nil?'

  def line_exist
  	unless BidLine.where("lines->>'line_number' = ?", bid_line.to_s).exists?
  		 errors.add(:bid_line, "This is not a valid bid line #")
  	end
  end
end
