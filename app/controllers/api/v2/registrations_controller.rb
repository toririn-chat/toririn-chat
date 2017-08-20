class Api::V2::RegistrationsController < Devise::RegistrationsController
  respond_to :json
end
