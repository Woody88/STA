class ShiftsController < ApplicationController
  respond_to :json
  def index
  	@user = current_user.profile
  	@shifts = @user.shifts 
  end
end
