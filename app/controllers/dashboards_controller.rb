class DashboardsController < ApplicationController
	before_action :authenticate_employee!
  
  respond_to :js	
	
  def index
  	today = Date.today.to_s(:long)
  	@today_task = profile.shifts.where(date: today).first
  	@posts = Post.all.order("created_at DESC").limit(20)
  	@shift_for_trade = ShiftForTrade.count
  	@available_employees = Shift.where(:date => Date.today, :available => true).count
  	js 'Dashboards'
  end

  def trade_center_info
  	@shift_for_trade = ShiftForTrade.count
  	@available_employees = Shift.where(:date => Date.today, :available => true).count
  end
end
