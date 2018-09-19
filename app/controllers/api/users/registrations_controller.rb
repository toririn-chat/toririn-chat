class Api::Users::RegistrationsController < Devise::RegistrationsController

  respond_to :json

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      keys = [:person_name, :organization_name]
      devise_parameter_sanitizer.permit :sign_up, keys: keys
    end

end
