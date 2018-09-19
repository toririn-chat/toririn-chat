class Api::ApiController < ActionController::API
end

if ENV['AUTO_LOGIN'].present?
  Api::ApiController.class_eval do
    def authenticate_user!
      true
    end
    def current_user
      User.find_by_email('test@example.net')
    end
  end
end
