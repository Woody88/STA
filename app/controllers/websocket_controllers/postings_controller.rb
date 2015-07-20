class WebsocketControllers::PostingsController < WebsocketRails::BaseController

	def new_post
		puts 'message:' + message
		post = profile.posts.create!(content: message)
		@p = post.attributes.merge!({user: post.profile.attributes})
		broadcast_message :new_post, @p
		WebsocketRails[:posts].trigger(:new_post, @p)
	end

    def format_post(post)
      p = p.attributes.symbolize_keys!
      p[:id] = p.id
      p[:profile] = p.profile._id
      p[:created_at] = time_ago_in_words(post.created_at)
      p[:conent] = post.content
	      p[:user] = {:fname => p.user.fname, :lfname => p.user.lname}
	      return p 
	end
end