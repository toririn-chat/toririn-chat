class Api::UsersController < ActionController::API

  def show
    @user = current_user
    render json: {
      person_name: @user.person_name,
      organization_name: @user.organization_name,
      email: @user.email
    }
  end

end
