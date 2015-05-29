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
    
    protected
    
    def after_update_path_for(resource)
      profile_path(resource)
    end

  	private 

end
