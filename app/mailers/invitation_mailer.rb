class InvitationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invitation_mailer.new_user_space_invite.subject
  #

  def invite_space invitation, link
    @invitation = invitation
    @send_name = @invitation.sender.name
    @link = link
    @space = Space.find(invitation.space_id)
    mail to: invitation.email, subject: @space.name + '공간에 초대합니다.' # code here
  end
end
