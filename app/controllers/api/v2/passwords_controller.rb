class Api::V2::PasswordsController < Devise::PasswordsController
  respond_to :json
end
