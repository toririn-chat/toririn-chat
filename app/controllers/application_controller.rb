class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def session_create(user_id)
    cookies.signed['user.id'] = user_id
  end

  def session_destroy
    cookies.signed['user.id'] = nil
  end

  def current_user
    @current_user ||= User.find_by(id: cookies.signed['user.id'])
  end

  def authenticate_user!
    unless current_user
      redirect_to root_path
    end
  end

  helper_method :current_user
  helper_method :authenticate_user!

end
