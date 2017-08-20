class Api::V2::SessionsController < Devise::SessionsController
  respond_to :json
end
