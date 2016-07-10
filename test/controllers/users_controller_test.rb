require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:user_0)
  end

  test 'create user' do
    assert_difference('User.count') do
      post users_url(format:'json'), {params:{user:{name:@user.name, icon:@user.icon}}}
    end
    assert_response :success
  end

  test 'update user' do
    patch user_url(@user, format:'json'), {params:{user:{name:@user.name, icon:@user.icon}}}
    assert_response :success
  end

end
