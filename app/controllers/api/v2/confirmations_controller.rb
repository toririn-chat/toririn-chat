class Api::V2::ConfirmationsController < Devise::ConfirmationsController

  respond_to :json

  # @see https://github.com/plataformatec/devise/blob/master/app/controllers/devise/confirmations_controller.rb
  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?
    if resource.errors.empty?
      respond_with(resource)
    else
      respond_with(resource.errors, status: :unprocessable_entity)
    end
  end

end
