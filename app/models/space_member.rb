class SpaceMember < ApplicationRecord

  def isAllowed current_user
    SpaceMember.find_by_user_id(current_user.id) != nil
  end
end
