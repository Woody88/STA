class ProfileAccountController < Devise::RegistrationsController
	def after_sign_up_path_for(resource)
    	profile_path(resource)
  	end

  	def edit
  		@profile = current_user.profile
  	end

  	def update
  		super
  	end

  	private 

  	
end
