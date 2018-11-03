class SpacesController < ApplicationController
  before_action :set_space, only: [:show, :edit, :update, :destroy]

  # GET /spaces
  # GET /spaces.json
  def index
    @spaces_mine = Space.mine(current_user.id)
    @spaces_membered = nil
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
    @space = Space.new(space_params.merge(user_id: current_user.id))
    @space.save

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
    @text = params[:text]
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_space
    @space = Space.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def space_params
    params.require(:space).permit(:name, :url, :is_public, :user_id)
  end

  def broadcast_create_space(space)
    ActionCable.server.broadcast "all_spaces", {action: "create", id: space.id}
  end

  def broadcast_delete_space(space)
    ActionCable.server.broadcast "all_spaces", {action: "delete", id: "space-#{space.id}"}
  end

  def broadcast_update_space(space)
    ActionCable.server.broadcast "all_spaces", {action: "update", id: space.id}
  end
end