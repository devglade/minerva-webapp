require 'test_helper'

class InvitationsControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in @user1
    @space = create(:space)
  end

  test 'invitation should get new' do
    get new_invitation_path(space_id: @space), xhr: true
    assert_response :success
  end
end
