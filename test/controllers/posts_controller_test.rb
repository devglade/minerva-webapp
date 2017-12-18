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

end
