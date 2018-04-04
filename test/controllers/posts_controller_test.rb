require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in @user1
    @user2 = FactoryBot.create(:user)
    @space = create(:space)
    @project = create(:project)
    @spin = create(:spin)
    @section = create(:section)
    @post = create(:post)
  end

  test "[post] should get index" do
    get space_project_spin_posts_url @space, @project, @spin
    assert_response :success
  end

  test "[post] should get new" do
    get new_space_project_spin_post_url(@space, @project, @spin), xhr: true
    assert_response :success
    post = assigns(:post)
    assert_not_nil post
  end

  test "[post] should create post" do
    assert_difference('Post.count') do
      post space_project_spin_posts_url(@space, @project, @spin), params: {post: {content: "test"}}, xhr: true
    end
    assert_response :success
  end
  test "[post] should show post" do
    get space_project_spin_post_url(@space, @project, @spin, @post), xhr: true
    assert_response :success
  end

  test "[post] should update post" do
    sign_out @user1
    sign_in @post.user
    patch space_project_spin_post_url @space, @project, @spin, @post, params: {post: {content: "changed"}}, format: :js
    assert_response :success
    assert_equal "changed", assigns(:post).content
  end

  test "[post] should destroy post" do
    sign_out @user1
    sign_in @post.user
    assert_difference('Post.count', -1) do
      delete space_project_spin_post_path(@space, @project, @spin, @post), xhr: true
    end
    assert_response :success
  end

  test "[post] 다른 사람이 쓴 포스트는 수정할 수 없다." do
    sign_in @user1
    post space_project_spin_posts_url(@space, @project, @spin), params: {post: {content: "test"}}, xhr: true
    sign_out @user1
    sign_in @user2
    last = Post.last
    patch space_project_spin_post_url @space, @project, @spin, last, params: {post: {content: "changed"}}, format: :js
    assert_equal "test", last.content
  end

  test "[post] 다른 사람이 쓴 포스트는 삭제할 수 없다." do
    sign_out @user1
    post space_project_spin_posts_url(@space, @project, @spin), params: {post: {content: "test"}}, xhr: true
    sign_out @user1
    sign_in @user2
    assert_difference('Post.count', 0) do
      delete space_project_spin_post_path(@space, @project, @spin, @post), xhr: true
    end
    assert_response :success
  end

  test '[post] 자신의 글에 좋아요/싫어요를 못한다' do
    sign_in @post.user
    put like_space_project_spin_post_path(@space, @project, @spin, @post), xhr: true
    assert_template :access_denied
    put dislike_space_project_spin_post_path(@space, @project, @spin, @post), xhr:true
    assert_template :access_denied
  end

  test '[post] 좋아요 취소가 되어야 한다.' do
    sign_in @user2
    put like_space_project_spin_post_path(@space, @project, @spin, @post), xhr: true
    assert_equal @post.get_upvotes.size, 1
    put like_space_project_spin_post_path(@space, @project, @spin, @post), xhr: true
    assert_equal @post.get_upvotes.size, 0
  end

  test '[post] 싫어요 취소가 되어야 한다.' do
    sign_in @user2
    put dislike_space_project_spin_post_path(@space, @project, @spin, @post), xhr: true
    assert_equal @post.get_downvotes.size, 1
    put dislike_space_project_spin_post_path(@space, @project, @spin, @post), xhr: true
    assert_equal @post.get_downvotes.size, 0
  end
end
