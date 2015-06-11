module ApplicationHelper
	def title(page_title)
  		content_for :title, page_title.to_s
	end


	def avatar_url(user)
    	default_url = "http://www.gravatar.com/avatar/HASH"
    	gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    	"http://gravatar.com/avatar/#{gravatar_id}.png?s=200{CGI.escape(default_url)}"
  end
end
