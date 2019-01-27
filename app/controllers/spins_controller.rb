class SpinsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:index, :new, :create]
  before_action :set_spin, only: [:show, :edit, :update, :destroy, :get_spin]

  def index
    @spins = @project.spins.by_created_at
    # @opened_spin_count = @spins.opened.count
  end

  def show
    @sections = Section.sorted
    respond_to do |format|
      format.html
      format.js
    end
  end

  def get_spin
    render partial: @spin
  end

  def new
    if @space.is_public
      raise User::NotAuthorized, '초대받은 사람만 생성할 수 있습니다.' unless @space.isAllowed current_user.id
    end

    @spin = Spin.new
  end

  def edit
  end

  def create
    if @space.is_public
      raise User::NotAuthorized, '초대받은 사람만 생성할 수 있습니다.' unless @space.isAllowed current_user.id
    end

    @spin = @project.spins.build(spin_params.merge(status: "opened"))
    @spin.save

    broadcast_create_spin(@spin)
  end

  def update
    if @space.is_public
      raise User::NotAuthorized, '초대받은 사람만 생성할 수 있습니다.' unless @space.isAllowed current_user.id
    end

    @spin.update_attributes(spin_params)

    broadcast_update_spin(@spin)
  end

  def destroy
    @spin.destroy

    broadcast_delete_spin(@spin)
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
    @space = @project.space
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_spin
    @spin = Spin.find_by_id(params[:id])
    @project = @spin.project
    @space = @project.space
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def spin_params
    local_params = params.require(:spin).permit(:status, :title, :summary)
    local_params = local_params.merge(user: current_user)
    return local_params
  end

  def broadcast_create_spin(spin)
    ActionCable.server.broadcast "#{spin.project.id}_spins", {action: "create", id: spin.id, project_id: @project.id}
  end

  def broadcast_delete_spin(spin)
    ActionCable.server.broadcast "#{spin.project.id}_spins", {action: "delete", id: spin.id}
  end

  def broadcast_update_spin(spin)
    ActionCable.server.broadcast "#{spin.project.id}_spins", {action: "update", id: spin.id}
  end
end
