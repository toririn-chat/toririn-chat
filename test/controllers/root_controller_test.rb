require 'test_helper'

class RootControllerTest < ActionDispatch::IntegrationTest

  test 'get /' do
    get root_url
    assert_response :success
  end

  test 'get /about' do
    get about_url
    assert_response :success
  end

end
