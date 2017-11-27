require 'test_helper'

class RetrospectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in @user1
    @retrospect = create(:retrospect)
  end

  test '로그인 안한 사용자는 회고를 볼 수 없다.' do
    sign_out @user1
    get retrospects_path

    assert_response 302
  end

  test "should get index" do
    get retrospects_path
    assert_response :success
  end

  test "should get new" do
    get new_retrospect_path, xhr: true
    assert_response :success
    retrospect = assigns(:retrospect)
    assert_not_nil retrospect
  end

  test "should create retrospect" do
    assert_difference 'Retrospect.count' do
      post retrospects_url, params: {retrospect: attributes_for(:retrospect)}, xhr: true
    end

    assert_response :success
    assert_template 'retrospects/create'
  end

  test "should show retrospect" do
    get retrospect_path(@retrospect)

    assert_response :success
    assert_not_nil assigns(:retrospect)
  end

  test "should get edit" do
    get edit_retrospect_path(@retrospect), xhr: true
    assert_response :success
  end

  test "should update retrospect" do
    id = @retrospect.id
    patch retrospect_url(@retrospect), params: {retrospect: {description: @retrospect.description, title: "test", user_id: @retrospect.user_id}}, xhr: true
    assert_response :success
    assert_equal "test", Retrospect.find(id).title
  end

    # test "should destroy retrospect" do
    #   assert_difference('Retrospect.count', -1) do
    #     delete retrospect_url(@retrospect)
    #   end
    #
    #   assert_redirected_to retrospects_url
    # end
end
