class TradeCenterController < ApplicationController
  before_action :authenticate_user!
  before_action :set_shift, only: [:cancel_shift, :pick_up_shift, :post_shift]
  def all_posted_shifts
  	@posted_shifts = Shift.with_posted_state.includes(:profile)
  end

  def post_shift
  end

  def submit_shift
    @shift = Shift.find(params[:shift][:id])
    if !@shift.posted?
        flash[:notice] = 'Shift successfully Posted.' if @shift.post!
        redirect_to posted_shifts_path
    else
        flash[:alert] = 'Shift already on Trade Board!'
        redirect_to @shift
    end
  end

  def pick_up_shift
  end

  private

  def set_shift
    @shift = Shift.find(params[:id])
  end
end
