class ProjectsController < ApplicationController
  before_action :set_retrospect, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @projects = Project.all.order('created_at DESC')

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    render partial: @project
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params.merge(user_id: current_user.id))
    @project.save

    broadcast_create_retrospect(@project)
  end

  # PATCH/PUT /retrospects/1
  # PATCH/PUT /retrospects/1.json
  def update
    raise User::NotAuthorized, '수정할 권한이 없습니다.' unless @project.updatable_by?(current_user)
    @project.update_attributes(project_params)

    broadcast_update_retrospect(@project)
  end

  # DELETE /retrospects/1
  # DELETE /retrospects/1.json
  def destroy
    raise User::NotAuthorized, '삭제할 권한이 없습니다.' unless @project.updatable_by?(current_user)
    @project.destroy

    broadcast_delete_retrospect(@project)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_retrospect
    @project = Project.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:title, :description, :user_id)
  end

  def broadcast_create_retrospect(retrospect)
    ActionCable.server.broadcast "all_projects", {action: "create", id: retrospect.id}
  end

  def broadcast_delete_retrospect(retrospect)
    ActionCable.server.broadcast "all_projects", {action: "delete", id: "project-#{retrospect.id}"}
  end

  def broadcast_update_retrospect(retrospect)
    ActionCable.server.broadcast "all_projects", {action: "update", id: retrospect.id}
  end

end
