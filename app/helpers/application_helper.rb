module ApplicationHelper
	def title(page_title)
  		content_for :title, page_title.to_s
	end

	def profile
		current_user.profile
	end
end
