class RetrospectsController < ApplicationController
  before_action :set_retrospect, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @retrospects = Retrospect.all.order('created_at DESC')

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    render partial: @retrospect
  end

  def new
    @retrospect = Retrospect.new
  end

  def edit
  end

  def create
    @retrospect = Retrospect.new(retrospect_params.merge(user_id: current_user.id))
    @retrospect.save

    broadcast_create_retrospect(@retrospect)
  end

  # PATCH/PUT /retrospects/1
  # PATCH/PUT /retrospects/1.json
  def update
    raise User::NotAuthorized, '수정할 권한이 없습니다.' unless @retrospect.updatable_by?(current_user)
    @retrospect.update_attributes(retrospect_params)

    broadcast_update_retrospect(@retrospect)
  end

  # DELETE /retrospects/1
  # DELETE /retrospects/1.json
  def destroy
    raise User::NotAuthorized, '삭제할 권한이 없습니다.' unless @retrospect.updatable_by?(current_user)
    @retrospect.destroy

    broadcast_delete_retrospect(@retrospect)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_retrospect
    @retrospect = Retrospect.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def retrospect_params
    params.require(:retrospect).permit(:title, :description, :user_id)
  end

  def broadcast_create_retrospect(retrospect)
    ActionCable.server.broadcast "all_retrospects", {action: "create", id: retrospect.id}
  end

  def broadcast_delete_retrospect(retrospect)
    ActionCable.server.broadcast "all_retrospects", {action: "delete", id: "retrospect-#{retrospect.id}"}
  end

  def broadcast_update_retrospect(retrospect)
    html = ApplicationController.render partial: "retrospects/retrospect", locals: {current_user: current_user, retrospect: retrospect}, formats: [:html]
    ActionCable.server.broadcast "all_retrospects", {action: "update", id: "retrospect-#{retrospect.id}", html: html}
  end

end
