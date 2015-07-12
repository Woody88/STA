class DashboardsController < ApplicationController
	before_action :authenticate_employee!
  def index
  	today = Date.today.to_s(:long)
  	@today_task = profile.shifts.where(date: today).first
  	@posts = Post.all.order("created_at DESC").limit(20)
  end
end
