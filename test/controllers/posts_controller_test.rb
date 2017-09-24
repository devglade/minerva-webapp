require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "로그인 안 한 사람은 포스트글을 볼 수 없다" do
    post = posts(:one)
    get posts_url(post)
    assert_response 401
  end

  test "로그인 한 사람은 포스트를 볼 수 있다" do
    assert true
  end

  test "자신의 글은 삭제 할 수 있다." do
    assert true
  end

  test "다른 사람의 글은 삭제 할 수 없다." do
    assert true
  end
end
