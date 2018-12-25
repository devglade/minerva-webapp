require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in @user1
    @user2 = FactoryBot.create(:user)
    @space = create(:space)
    @project = create(:project, space: @space)
    @spin = create(:spin, project: @project)
    @section = create(:section, spin: @spin)
    @post = create(:post, section: @section)
  end

  test "[post] should create post" do
    assert_difference('Post.count') do
      post space_project_spin_section_posts_path(@space, @project, @spin, @section), params: {post: {content: "test"}}, as: :json
    end
    assert_response :success
  end
  test "[post] should show post" do
    # get space_project_spin_post_url(@space, @project, @spin, @post), xhr: true
    # assert_response :success
  end

  test "[post] should update post" do
    sign_out @user1
    sign_in @post.user
    patch space_project_spin_section_post_path(@space, @project, @spin, @section, @post), params: {post: {content: "changed"}}, as: :json
    assert_response :success
    assert_equal "changed", assigns(:post).content
  end

  test "[post] should destroy post" do
    sign_out @user1
    sign_in @post.user
    assert_difference('Post.count', -1) do
      delete space_project_spin_section_post_path(@space, @project, @spin, @section, @post), as: :json
    end
    assert_response :success
  end

  test "[post] 다른 사람이 쓴 포스트는 수정할 수 없다." do
    sign_in @user1
    post space_project_spin_section_posts_path(@space, @project, @spin, @section), params: {post: {content: "test"}}, as: :json
    sign_out @user1
    sign_in @user2
    last = Post.last

    patch space_project_spin_section_post_path(@space, @project, @spin, @section, last), params: {post: {content: "changed"}}
    assert_equal "test", last.content
  end

  test "[post] 다른 사람이 쓴 포스트는 삭제할 수 없다." do
    # sign_out @user1
    # post space_project_spin_posts_url(@space, @project, @spin), params: {post: {content: "test"}}, xhr: true
    # sign_out @user1
    # sign_in @user2
    # assert_difference('Post.count', 0) do
    #   delete space_project_spin_post_path(@space, @project, @spin, @post), xhr: true
    # end
    # assert_response :success
  end

  test '[post] 자신의 글에 좋아요/싫어요를 못한다' do
    # sign_in @post.user
    # put like_space_project_spin_post_path(@space, @project, @spin, @post), xhr: true
    # assert_template :access_denied
    # put dislike_space_project_spin_post_path(@space, @project, @spin, @post), xhr: true
    # assert_template :access_denied
  end

  test '[post] 좋아요 취소가 되어야 한다.' do
    # sign_in @user2
    # put like_space_project_spin_post_path(@space, @project, @spin, @post), xhr: true
    # assert_equal @post.get_upvotes.size, 1
    # put like_space_project_spin_post_path(@space, @project, @spin, @post), xhr: true
    # assert_equal @post.get_upvotes.size, 0
  end

  test '[post] 싫어요 취소가 되어야 한다.' do
    # sign_in @user2
    # put dislike_space_project_spin_post_path(@space, @project, @spin, @post), xhr: true
    # assert_equal @post.get_downvotes.size, 1
    # put dislike_space_project_spin_post_path(@space, @project, @spin, @post), xhr: true
    # assert_equal @post.get_downvotes.size, 0
  end
end
