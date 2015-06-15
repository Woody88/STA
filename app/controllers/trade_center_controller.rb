class TradeCenterController < ApplicationController
  before_action :authenticate_user!
  before_action :set_shift, only: [:cancel_shift, :pick_up_shift]
  before_action :set_original_shift, only: [:pick_up_shift]
  before_action :set_dup_shift, only: [:post_shift]
  def all_posted_shifts
  	@posted_shifts = Shift.with_shift_trade_state.includes(:profile)
  end

  def post_shift
  end

  def submit_shift
    @shift = Shift.find(params[:shift][:original_id])
    start = Time.parse(params[:shift][:start_time])
    finish = Time.parse(params[:shift][:finish_time])
    @dup_shift = @shift.dup
    temp_start = @dup_shift.start_time.change(hour: start.hour, min: start.min)
    temp_finish = @dup_shift.finish_time.change(hour: finish.hour, min: finish.min)
    @dup_shift.start_time = temp_start
    @dup_shift.finish_time = temp_finish
    @dup_shift.profile_id = profile.id
    @dup_shift.trade_id = @shift.id

    if !@shift.posted?
      if @dup_shift.save 
        flash[:notice] = 'Shift successfully Posted.' if @shift.post! &&  @dup_shift.shift_trade!
        redirect_to posted_shifts_path
      else
        flash[:alert] = 'Could not post your shift on Trade Board!'
        redirect_to @shift
      end
    else
        flash[:alert] = 'Shift already on Trade Board!'
        redirect_to post_shift_path(@shift)
    end
  end

  def pick_up_shift
     if profile.available?(@shift)

        #Needs Major refactoring but will concentrate on it later need to see it work first!
        if !@shift.eql?(@original_shift)
          if !@original_shift.start_time.eql?(@shift.start_time)
            temp = @original_shift.finish_time.change(hour: @shift.start_time.hour, min: @shift.start_time.min)
            @original_shift.finish_time = temp

          elsif !@original_shift.finish_time.eql?(@shift.finish_time)
            temp = @original_shift.start_time.change(hour: @shift.finish_time.hour, min: @shift.finish_time.min)
            @original_shift.start_time = temp
          end
          
        end

        @shift.profile_id = profile.id
        
        if @shift.save && @original_shift.save && @shift.sold! && @original_shift.sold!
            flash[:notice] = 'Shift successfully traded.' 
            redirect_to calendar_path
        else
            flash[:alert] = "Shift Could not be Traded"
             redirect_to posted_shifts_path
        end
    else
        flash[:alert] = "#{current_user.email} are already working that day."
        redirect_to posted_shifts_path
    end
    
  end


  def cancel_shift
     @shift = Shift.find(params[:id])
     flash[:notice] = 'Shift successfully removed from board.' if @shift.destroy
     redirect_to posted_shifts_path
  end

  private

  def post_shift_params
    params.require(:shift).permit(:position, :date, :start_time, :finish_time, :description, :workflow_state, :scheduled, :profile_id, :trade_id)
  end

  def set_shift
    @shift = Shift.find(params[:id])
  end

  def set_original_shift
    @original_shift = Shift.find(@shift.trade_id)
  end

  def set_dup_shift
    @shift = Shift.find(params[:id])
    @dup = @shift.dup
  end
end
