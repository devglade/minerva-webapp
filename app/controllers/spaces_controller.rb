class SpacesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_space, only: [:show, :edit, :update, :destroy]

  SPACE_LIMIT = 2

  # GET /spaces
  # GET /spaces.json
  def index
    token = params[:invite_space_token]
    if token != nil
      if Invitation.is_invited_member current_user, token
        message = SpaceMember.join_if_needed current_user, token
        flash.now[:notice] = message
      else
        flash.now[:error] = "초대받은 이메일로 로그인을 하셔야합니다."
      end
    end

    @space_limit = 2
    @spaces_mine = Space.mine(current_user.id)
    @joined_spaces = SpaceMember.joined(current_user.id)
  end

  # GET /spaces/1
  # GET /spaces/1.json
  def show
    render partial: @space
  end

  # GET /spaces/new
  def new
    @space = Space.new
  end

  # GET /spaces/1/edit
  def edit
  end

  # POST /spaces
  # POST /spaces.json
  def create
    @spaces_mine = Space.mine(current_user.id)
    raise Space::NotAllowed, '공간 생성 한도를 초과했습니다.' if over_space_limit
    @space = Space.new(space_params.merge(user_id: current_user.id))
    @space.save
    flash.now[:error] = @space.errors.messages[:url] if @space.errors.any?
    broadcast_create_space(@space)
  end

  # PATCH/PUT /spaces/1
  # PATCH/PUT /spaces/1.json
  def update
    raise User::NotAuthorized, '수정할 권한이 없습니다.' unless @space.updatable_by?(current_user)
    @space.update_attributes(space_params)

    broadcast_update_space(@space)
  end

  # DELETE /spaces/1
  # DELETE /spaces/1.json
  def destroy
    raise User::NotAuthorized, '삭제할 권한이 없습니다.' unless @space.updatable_by?(current_user)
    @space.destroy

    broadcast_delete_space(@space)
  end

  def search
    if params[:text].present?
      @spaces = Space.opend.contains_keyword(params[:text])
    else
      @spaces = Space.opend.all
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_space
    @space = Space.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def space_params
    params.require(:space).permit(:name, :description, :url, :is_public, :user_id)
  end

  def over_space_limit
    Space.mine(current_user.id).count >= SPACE_LIMIT
  end

  def broadcast_create_space(space)

    ActionCable.server.broadcast "#{current_user.email}_spaces", {action: "create", id: space.id, state: over_space_limit ? 'hide' : 'show'}
  end

  def broadcast_delete_space(space)
    @spaces_mine = Space.mine(current_user.id)
    ActionCable.server.broadcast "#{current_user.email}_spaces", {action: "delete", id: "space-#{space.id}", state: over_space_limit ? 'hide' : 'show'}
  end

  def broadcast_update_space(space)
    ActionCable.server.broadcast "#{current_user.email}_spaces", {action: "update", id: space.id}
  end
end