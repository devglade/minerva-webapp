require 'test_helper'

class SectionsControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in @user1
    @space = create(:space)
    @project = create(:project)
    @spin = create(:spin)
  end

  test "should get new" do
    get new_space_project_spin_section_url(@space, @project, @spin), xhr: true
    assert_response :success
  end

end
