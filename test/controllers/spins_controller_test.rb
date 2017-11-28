require 'test_helper'

class SpinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in @user1
    @retrospect = create(:retrospect)
    @spin = create(:spin)
  end

  test "should get index" do
    get retrospect_spin_url @retrospect, @spin
    assert_response :success
  end

  test "should get new" do
    get new_retrospect_spin_url(@retrospect, @spin), xhr: true
    assert_response :success
    spin = assigns(:spin)
    assert_not_nil spin
  end

  test "should create spin" do
    assert_difference('Spin.count') do
      post retrospect_spins_url @retrospect, @spin, params: { spin: { status: @spin.status, summary: @spin.summary, title: @spin.title } }
    end
    assert_response :success
  end

  test "should show spin" do
    get retrospect_spin_url @retrospect, @spin
    assert_response :success
  end

  test "should get edit" do
    get edit_retrospect_spin_url(@retrospect, @spin, params: { spin: { status: @spin.status, summary: @spin.summary, title: @spin.title } }), xhr: true
    assert_response :success
  end

  test "should update spin" do
    patch retrospect_spin_url @retrospect, @spin, params: { spin: { status: @spin.status, summary: @spin.summary, title: "changed" } }, format: :js
    assert_response :success
    assert_equal "changed", Spin.find(@spin.id).title
  end

  test "should destroy spin" do
    assert_difference('Spin.count', -1) do
      delete retrospect_spin_url(@retrospect, @spin, format: :json), xhr: true
    end
    assert_response :success
  end
end
