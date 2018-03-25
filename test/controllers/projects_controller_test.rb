require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in @user1
    @user2 = FactoryBot.create(:user)
    @space = FactoryBot.create(:space)
    @project = create(:project)
  end

  test '로그인 안한 사용자는 회고를 볼 수 없다.' do
    sign_out @user1
    get space_projects_path @space

    assert_response 302
  end

  test '로그인 안한 사용자는 회고를 쓸 수 없다.' do
    sign_out @user1
    assert_no_difference 'Project.count' do
      post space_projects_path(@space), params: {project: attributes_for(:project)}, xhr: true
    end
  end

  test "should get index" do
    get projects_path
    assert_response :success
  end

  test "should get new" do
    get new_project_path, xhr: true
    assert_response :success
    project = assigns(:project)
    assert_not_nil project
  end

  test "should create project" do
    assert_difference 'Project.count' do
      post projects_url, params: {project: attributes_for(:project)}, xhr: true
    end
    assert_response :success
    assert_template 'projects/create'
  end

  test "should show project" do
    get project_path(@project)

    assert_response :success
    assert_not_nil assigns(:project)
  end

  test "should get edit" do
    get edit_project_path(@project), xhr: true
    assert_response :success
  end

  test "should update project" do
    id = @project.id
    sign_in @project.user
    patch project_url(@project), params: {project: {description: @project.description, title: "test", user_id: @project.user_id}}, xhr: true
    assert_response :success
    assert_equal "test", Project.find(id).title
  end

  test "should destroy project" do
    sign_in @project.user
    assert_difference('Project.count', -1) do
      delete project_url(@project), xhr: true
    end
  end

  test '다른 사람이 쓴 회고는 삭제할 수 없다.' do
    sign_out @project.user
    assert_no_difference 'Project.count' do
      delete project_url(@project), xhr: true
    end
  end
end
