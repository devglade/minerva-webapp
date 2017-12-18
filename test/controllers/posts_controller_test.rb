require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in @user1
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

  test "should update spin" do
    patch retrospect_spin_post_url @retrospect, @spin, @post, params: {post: {content: "changed"}}, format: :js
    assert_response :success
    assert_equal "changed", Post.find(@post.id).content
  end

  test "should destroy spin" do
    assert_difference('Post.count', -1) do
      delete retrospect_spin_post_path(@retrospect, @spin, @post), xhr: true
    end
    assert_response :success
  end
end
