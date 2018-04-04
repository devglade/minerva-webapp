require 'test_helper'

class SpacesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in @user1
    @space = create(:space)
  end

  test "[space] should get index" do
    get spaces_url
    assert_response :success
  end

  test "[space] should get new" do
    get new_space_url, xhr: true
    assert_response :success
  end

  test "[space] should create space" do
    assert_difference('Space.count') do
      post spaces_url, params: { space: { is_public: @space.is_public, name: @space.name, url: @space.url, user_id: @space.user_id } }, xhr: true
    end
    assert_response :success
    assert_template 'spaces/create'
  end

  test "[space] should show space" do
    get space_url(@space)
    assert_response :success
  end

  test "[space] should get edit" do
    get edit_space_path(@space), xhr: true
    assert_response :success
  end

  test "[space] should update space" do
    id = @space.id
    sign_in @space.user
    patch space_path(@space), params: { space: { is_public: @space.is_public, name: "test", url: @space.url, user_id: @space.user_id } }, xhr: true
    assert_response :success
    assert_equal "test", Space.find(id).name
  end

  test "[space] should destroy space" do
    sign_in @space.user
    assert_difference('Space.count', -1) do
      delete space_path(@space), xhr: true
    end
  end
end
