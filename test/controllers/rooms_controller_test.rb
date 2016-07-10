require 'test_helper'

class RoomsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @room = rooms(:room_0)
  end

  test 'get /rooms' do
    get rooms_url
    assert_response :success
  end

  test 'get /rooms/{id}' do
    get room_url(@room)
    assert_response :success
  end

  test '/rooms renders links to rooms' do
    get rooms_url
    assert_response :success
    assert_select 'ul.rooms li a[href]'
  end

  test '/room/{id} renders messages' do
    get room_url(@room)
    assert_response :success
    assert_select 'ul.messages li'
  end

end
