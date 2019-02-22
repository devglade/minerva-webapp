class ProjectsController < ApplicationController
  before_action :set_space, only: [:index, :new, :create]
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    unless @space.is_public
      raise User::NotAuthorized unless @space.isAllowed current_user.id
    end
    @projects = @space.projects.by_created_at
  end

  def show
    render partial: @project
  end

  def new
    if @space.is_public
      raise User::NotAuthorized, '초대받은 사람만 생성할 수 있습니다.' unless @space.isAllowed current_user.id
    end
    @project = Project.new
  end

  def edit
  end

  def create
    if @space.is_public
      raise User::NotAuthorized, '초대받은 사람만 생성할 수 있습니다.' unless @space.isAllowed current_user.id
    end
    @project = Project.new(project_params.merge(user_id: current_user.id))
    @project.space = @space
    @project.save

    broadcast_create_project(@project)
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    raise User::NotAuthorized, '수정할 권한이 없습니다.' unless @project.updatable_by?(current_user)
    @project.update_attributes(project_params)

    broadcast_update_project(@project)
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    raise User::NotAuthorized, '삭제할 권한이 없습니다.' unless @project.updatable_by?(current_user)
    @project.destroy

    broadcast_delete_project(@project)
  end

  private

  def set_space
    if request.subdomain != nil
      @space = Space.where(url: request.subdomain).first
    else
      @space = Space.find(params[:space_id])
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
    @space = @project.space
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:title, :description, :user_id)
  end

  def broadcast_create_project(project)
    ActionCable.server.broadcast "#{project.space.id}_projects", {action: "create", id: project.id}
  end

  def broadcast_delete_project(project)
    ActionCable.server.broadcast "#{project.space.id}_projects", {action: "delete", id: "project-#{project.id}"}
  end

  def broadcast_update_project(project)
    ActionCable.server.broadcast "#{project.space.id}_projects", {action: "update", id: project.id}
  end

end
