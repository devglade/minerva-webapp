require 'test_helper'

class SpinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in @user1
    @project = create(:project)
    @spin = create(:spin)
  end

  test "should get index" do
    get project_spin_url @project, @spin
    assert_response :success
  end

  test "should get new" do
    get new_project_spin_url(@project), xhr: true
    assert_response :success
    spin = assigns(:spin)
    assert_not_nil spin
  end

  test "스핀을 만들면 기본으로 section 2개를 만들어준다." do
    assert_difference('Spin.count') do
      post project_spins_url(@project), params: {spin: {status: @spin.status, summary: @spin.summary, title: @spin.title}}, xhr: true
    end
    assert_response :success
    spin = Spin.last
    assert_equal spin.sections.count, 2
  end

  test "should show spin" do
    get project_spin_url @project, @spin
    assert_response :success
  end

  test "should get edit" do
    get edit_project_spin_url(@project, @spin, params: {spin: {status: @spin.status, summary: @spin.summary, title: @spin.title}}), xhr: true
    assert_response :success
  end

  test "should update spin" do
    patch project_spin_url @project, @spin, params: {spin: {status: @spin.status, summary: @spin.summary, title: "changed"}}, format: :js
    assert_response :success
    assert_equal "changed", Spin.find(@spin.id).title
  end

  test "should destroy spin" do
    assert_difference('Spin.count', -1) do
      delete project_spin_url(@project, @spin), xhr: true
    end
    assert_response :success
  end
end
