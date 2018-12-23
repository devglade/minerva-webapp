require 'test_helper'

class InvitationsControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in @user1
    @space = create(:space)
  end

  test 'should get new' do
    get new_invitation_path(space_id: @space), xhr: true
    assert_response :success
  end

  test 'should create invitation' do
    assert_difference('Invitation.count') do
      post invitations_path(space_id: @space.id), params: {invitation: {space_id: @space.id, email: 'test@test.com', sender_id: @user1.id}}, xhr: true
    end

    assert_response :success
    assert_template 'invitations/create'
  end
end
