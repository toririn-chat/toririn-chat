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

  test '/ has path to rooms_path in article' do
    get root_url
    assert_select 'article a[href=?]', rooms_path
  end

  test '/about has path to rooms_path in nav' do
    get about_url
    assert_select 'nav a[href=?]', rooms_path
  end

end
