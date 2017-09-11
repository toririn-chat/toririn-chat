require 'test_helper'

class RoomsControllerTest < ActionDispatch::IntegrationTest

  class AuthorizedRoomsControllerTest < ActionDispatch::IntegrationTest

    include Warden::Test::Helpers

    setup do
      @room = rooms(:room_0)
      @user = users(:user_0)
      login_as(@user)
    end

    teardown do
      @room = nil
      @user = nil
      logout
    end

    test 'get /api/v2/rooms' do
      get api_v2_rooms_url
      assert_response :success
    end

    test 'get /api/v2/rooms/{id}' do
      get api_v2_room_url(@room)
      assert_response :success
    end

    test 'post /api/v2/rooms' do
      assert_difference('Room.count', +1) do
        post api_v2_rooms_url, {params:{room:{name:'The Test Room'}}}
      end
      assert_response :success
    end

    test 'patch /api/v2/rooms' do
      patch api_v2_room_url(@room), {params:{room:{name:@room.name}}}
      assert_response :success
    end

    test 'delete /api/v2/rooms/{id}' do
      assert_difference('Room.count', -1) do
        delete api_v2_room_url(@room)
      end
      assert_response :success
    end

  end

  class UnAuthorizedRoomsControllerTest < ActionDispatch::IntegrationTest

    setup do
      @room = rooms(:room_0)
      @user = users(:user_0)
    end

    teardown do
      @room = nil
      @user = nil
    end

    test 'get /api/v2/rooms' do
      get api_v2_rooms_url
      assert_response :unauthorized
    end

    test 'get /api/v2/rooms/{id}' do
      get api_v2_room_url(@room)
      assert_response :unauthorized
    end

    test 'post /api/v2/rooms' do
      post api_v2_rooms_url(format:'json'), {params:{room:{name:'The Test Room'}}}
      assert_response :unauthorized
    end

    test 'patch /api/v2/rooms' do
      patch api_v2_room_url(@room), {params:{room:{name:@room.name}}}
      assert_response :unauthorized
    end

    test 'delete /api/v2/rooms/{id}' do
      delete api_v2_room_url(@room)
      assert_response :unauthorized
    end

  end

end
