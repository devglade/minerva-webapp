require 'test_helper'

class RetrospectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @retrospect = retrospects(:one)
  end

  test "should get index" do
    get retrospects_url
    assert_response :success
  end

  test "should get new" do
    get new_retrospect_url
    assert_response :success
  end

  test "should create retrospect" do
    assert_difference('Retrospect.count') do
      post retrospects_url, params: { retrospect: { description: @retrospect.description, title: @retrospect.title, user_id: @retrospect.user_id } }
    end

    assert_redirected_to retrospect_url(Retrospect.last)
  end

  test "should show retrospect" do
    get retrospect_url(@retrospect)
    assert_response :success
  end

  test "should get edit" do
    get edit_retrospect_url(@retrospect)
    assert_response :success
  end

  test "should update retrospect" do
    patch retrospect_url(@retrospect), params: { retrospect: { description: @retrospect.description, title: @retrospect.title, user_id: @retrospect.user_id } }
    assert_redirected_to retrospect_url(@retrospect)
  end

  test "should destroy retrospect" do
    assert_difference('Retrospect.count', -1) do
      delete retrospect_url(@retrospect)
    end

    assert_redirected_to retrospects_url
  end
end
