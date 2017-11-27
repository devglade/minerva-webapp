require 'test_helper'

class SpinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in @user1
    @retrospect = create(:retrospect)
    @spin = create(:spin)
  end

  test "should get index" do
    get retrospect_spin_path @retrospect, @spin
    assert_response :success
  end

  test "should get new" do
    get new_retrospect_spin @retrospect, @spin
    assert_response :success
  end
  #
  # test "should create spin" do
  #   assert_difference('Spin.count') do
  #     post spins_url, params: { spin: { status: @spin.status, summary: @spin.summary, title: @spin.title } }
  #   end
  #
  #   assert_redirected_to spin_url(Spin.last)
  # end
  #
  # test "should show spin" do
  #   get spin_url(@spin)
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get edit_spin_url(@spin)
  #   assert_response :success
  # end
  #
  # test "should update spin" do
  #   patch spin_url(@spin), params: { spin: { status: @spin.status, summary: @spin.summary, title: @spin.title } }
  #   assert_redirected_to spin_url(@spin)
  # end
  #
  # test "should destroy spin" do
  #   assert_difference('Spin.count', -1) do
  #     delete spin_url(@spin)
  #   end
  #
  #   assert_redirected_to spins_url
  # end
end
