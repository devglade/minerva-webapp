class InvitationsController < ApplicationController

  def new
    @space = Space.find(params[:space_id])
    @invitation = Invitation.new
  end
end

