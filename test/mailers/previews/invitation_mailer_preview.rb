# Preview all emails at http://localhost:3000/rails/mailers/invitation_mailer
class InvitationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/invitation_mailer/new_user_space_invite
  def invite_space.html
    InvitationMailer.invite_space.html
  end

end
