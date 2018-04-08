require 'test_helper'

class SpinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in @user1
    @space = FactoryBot.create(:space)
    @project = FactoryBot.create(:project)
    @spin = create(:spin)
  end

  test "[spin] should get index" do
    get space_project_spin_path(@space, @project, @spin)
    assert_response :success
  end

  test "[spin] should get new" do
    get new_space_project_spin_path(@space, @project), xhr: true
    assert_response :success
    spin = assigns(:spin)
    assert_not_nil spin
  end

  test '[spin] should get show' do
    get space_project_spin_path(@space, @project, @spin)
    assert_response :success
  end

  test "[spin] 스핀을 만들면 기본으로 section 2개를 만들어준다." do
    assert_difference('Spin.count') do
      post space_project_spins_path(@space, @project), params: {spin: {status: @spin.status, summary: @spin.summary, title: @spin.title}}, xhr: true
    end
    assert_response :success
    spin = Spin.last
    assert_equal spin.sections.count, 2
  end

  test "[spin] should show spin" do
    get space_project_spin_path @space, @project, @spin
    assert_response :success
  end

  test "[spin] should get edit" do
    get edit_space_project_spin_path(@space, @project, @spin), params: {spin: {status: @spin.status, summary: @spin.summary, title: @spin.title}}, xhr: true
    assert_response :success
  end

  test "[spin] should update spin" do
    patch space_project_spin_path @space, @project, @spin, params: {spin: {status: @spin.status, summary: @spin.summary, title: "changed"}}, format: :js
    assert_response :success
    assert_equal "changed", Spin.find(@spin.id).title
  end

  test "[spin] should destroy spin" do
    assert_difference('Spin.count', -1) do
      delete space_project_spin_path(@space, @project, @spin), xhr: true
    end
    assert_response :success
  end
end
