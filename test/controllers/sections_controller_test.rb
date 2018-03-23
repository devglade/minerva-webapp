require 'test_helper'

class SectionsControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in @user1
    @project = create(:project)
    @spin = create(:spin)
  end

  test "should get new" do
    get new_project_spin_section_url(@project, @spin), xhr: true
    assert_response :success
  end

end
