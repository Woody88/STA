class AddDetailsToShift < ActiveRecord::Migration
  def change
    add_column :shifts, :description, :text
    add_column :shifts, :workflow_state, :string
    add_column :shifts, :shift_type, :string
    add_column :shifts, :original_owner, :integer
  end
end
