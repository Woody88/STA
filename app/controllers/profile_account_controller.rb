class ProfileAccountController < Devise::RegistrationsController
  require 'pry'
  require 'calendar_setup'

    def after_sign_up_path_for(resource)
    	profile_path(resource)
    end

  	def edit
  		@profile = current_user.profile
  	end

  	def update
      if params[:user][:profile_attributes][:bid_line].empty?
        super
      else
        super
      end
  	end
    
    protected
    
    def update_resource(resource, params)
      resource.update_without_password(params)
    end

    def after_update_path_for(resource)
      profile_path(resource)
    end

  	private 

end
