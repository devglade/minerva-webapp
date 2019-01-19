class InvitationsController < ApplicationController

  def new
    @space = Space.find(params[:space_id])
    @invitation = Invitation.new
    @sender_id = current_user.id
  end

  def create
    recipient = User.find_by_email(invitation_params[:email])
    if SpaceMember.exist_member recipient, invitation_params[:space_id]
      @space_name = Space.find(invitation_params[:space_id]).name
      @exist_member = true
      return
    end

    @invitation = Invitation.find_or_create_by invitation_params.merge(recipient_id: recipient == nil ? nil : recipient.id)
    if @invitation.recipient_id != nil
    else
      link = @invitation.new_user_invite_link(new_user_registration_url)
      @invitation.save
    end

    InvitationMailer.invite_space(@invitation, link).deliver
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email, :space_id, :sender_id)
  end

end
