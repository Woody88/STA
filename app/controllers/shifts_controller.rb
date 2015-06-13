class ShiftsController < ApplicationController
  before_action :authenticate_user!
  respond_to :json, :html
  def index
  	@user = current_user.profile
  	@shifts = @user.shifts

  	respond_with(@shifts) 
  end

  def show
  	@user = current_user.profile
  	@shift = @user.shifts.where(:id => params[:id])
  	respond_with(@shift)
  end
end
