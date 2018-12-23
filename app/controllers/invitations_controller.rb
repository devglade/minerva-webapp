class InvitationsController < ApplicationController

  def new
    @space = Space.find(params[:space_id])
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params)
    @invitation.sender_id = current_user.id
    if @invitation.save
      logger.debug "saved!"
    else
      logger.debug @invitation.errors.inspect
      logger.debug "failed!"
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email, :space_id)
  end
end

