require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in @user1
    @user2 = FactoryBot.create(:user)
    @retrospect = create(:retrospect)
    @spin = create(:spin)
    @post = create(:post)
  end

  test "should get index" do
    get retrospect_spin_posts_url @retrospect, @spin
    assert_response :success
  end

  test "should get new" do
    get new_retrospect_spin_post_url(@retrospect, @spin), xhr: true
    assert_response :success
    post = assigns(:post)
    assert_not_nil post
  end

  test "should create post" do
    assert_difference('Post.count') do
      post retrospect_spin_posts_url(@retrospect, @spin), params: {post: {content: "test"}}, xhr: true
    end
    assert_response :success
  end
  test "should show post" do
    get retrospect_spin_post_url @retrospect, @spin, @post
    assert_response :success
  end

  test "should update post" do
    sign_out @user1
    sign_in @post.user
    patch retrospect_spin_post_url @retrospect, @spin, @post, params: {post: {content: "changed"}}, format: :js
    assert_response :success
    assert_equal "changed", assigns(:post).content
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete retrospect_spin_post_path(@retrospect, @spin, @post), xhr: true
    end
    assert_response :success
  end

  test "다른 사람이 쓴 포스트는 수정할 수 없다." do
    sign_in @user1
    post retrospect_spin_posts_url(@retrospect, @spin), params: {post: {content: "test"}}, xhr: true
    sign_out @user1
    sign_in @user2
    last = Post.last
    patch retrospect_spin_post_url @retrospect, @spin, last, params: {post: {content: "changed"}}, format: :js
    assert_equal "test", last.content
  end

  test "다른 사람이 쓴 포스트는 삭제할 수 없다." do

  end
end
