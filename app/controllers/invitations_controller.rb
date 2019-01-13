class InvitationsController < ApplicationController

  def new
    @space = Space.find(params[:space_id])
    @invitation = Invitation.new
    @sender_id = current_user.id
  end

  def create
    @invitation = Invitation.new(invitation_params)
    if @invitation.save
      if User.find_by_email(@invitation.email) == nil
        link = @invitation.new_user_invite_link(new_user_registration_url)
      else
        # TODO
        link = nil
      end

      InvitationMailer.invite_space(@invitation, link).deliver
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email, :space_id, :sender_id)
  end
end

