require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in @user1
    @user2 = FactoryBot.create(:user)
    @space = FactoryBot.create(:space)
    @project = create(:project)
  end

  test '[project] 로그인 안한 사용자는 프로젝트를 볼 수 없다.' do
    sign_out @user1
    get space_projects_path @space

    assert_response 302
  end

  test '[project] 로그인 안한 사용자는 프로젝트를 쓸 수 없다.' do
    sign_out @user1
    assert_no_difference 'Project.count' do
      post space_projects_path(@space), params: {project: attributes_for(:project)}, xhr: true
    end
  end

  test "[project] should get index" do
    get space_project_path(@space, @project)
    assert_response :success
  end

  test "[project] should get new" do
    get new_space_project_path(@space), xhr: true
    assert_response :success
    project = assigns(:project)
    assert_not_nil project
  end

  test "[project] should create project" do
    assert_difference 'Project.count' do
      post space_projects_path(@space), params: {project: attributes_for(:project)}, xhr: true
    end
    assert_response :success
    assert_template 'projects/create'
  end

  test "[project] should show project" do
    get space_project_path(@space, @project)

    assert_response :success
    assert_not_nil assigns(:project)
  end

  test "[project] should get edit" do
    get edit_space_project_path(@space, @project), xhr: true
    assert_response :success
  end

  test "[project] should update project" do
    id = @project.id
    sign_in @project.user
    patch space_project_path(@space, @project), params: {project: {description: @project.description, title: "test", user_id: @project.user_id}}, xhr: true
    assert_response :success
    assert_equal "test", Project.find(id).title
  end

  test "[project] should destroy project" do
    sign_in @project.user
    assert_difference('Project.count', -1) do
      delete space_project_path(@space, @project), xhr: true
    end
  end

  test '다른 사람이 쓴 프로젝트는 삭제할 수 없다.' do
    sign_out @project.user
    assert_no_difference 'Project.count' do
      delete space_project_path(@space, @project), xhr: true
    end
  end
end
