class SpinsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_retrospect, only: [:index, :new, :create]
  before_action :set_spin, only: [:show, :edit, :update, :destroy]

  def index
    @spins = @project.spins.by_created_at
    # @opened_spin_count = @spins.opened.count
    #
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    render partial: @spin
  end

  def new
    @spin = Spin.new
  end

  def edit
  end

  def create
    @spin = @project.spins.build(spin_params.merge(status: "opened"))
    @spin.save

    broadcast_create_spin(@spin)
  end

  def update
    @spin.update_attributes(spin_params)

    broadcast_update_spin(@spin)
  end

  def destroy
    @spin.destroy

    broadcast_delete_spin(@spin)
  end

  private
  def set_retrospect
    @project = Project.find(params[:project_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_spin
    @spin = Spin.find(params[:id])
    @project = @spin.project
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
