class Api::V2::SessionsController < Devise::SessionsController
  respond_to :json

  def show
    respond_with(user_signed_in?)
  end

end
