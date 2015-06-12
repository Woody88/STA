class ShiftsController < ApplicationController
  before_action :authenticate_user!
  respond_to :json
  def index
  	@user = current_user.profile
  	@shifts = @user.shifts 
  end
end
