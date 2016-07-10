require 'test_helper'

class RootControllerTest < ActionDispatch::IntegrationTest

  test 'should get /' do
    get root_url
    assert_response :success
  end

  test 'should get /about' do
    get about_url
    assert_response :success
  end

end
