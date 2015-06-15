class AddTradeIdToShifts < ActiveRecord::Migration
  def change
    add_column :shifts, :trade_id, :integer
  end
end
