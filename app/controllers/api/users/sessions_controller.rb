class Api::Users::SessionsController < Devise::SessionsController

  respond_to :json

  def show
    if user_signed_in?
      render json: true
    else
      render json: false, status: :unauthorized
    end
  end

end
