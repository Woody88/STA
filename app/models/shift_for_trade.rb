class ShiftForTrade < Shift
	has_many :posted_shifts, :foreign_key => "shiftfortrade_id"
end