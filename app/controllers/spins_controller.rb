class SpinsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_retrospect, only: [:index, :new]
  before_action :set_spin, only: [:show, :edit, :update, :destroy]

  def index
    @spins = Spin.where(retrospect_id: params[:retrospect_id]).order('created_at DESC')
    @opened_spin_count = Spin.where(retrospect_id: params[:retrospect_id], status: "opened").count
  end

  def show
  end

  def new
    @spin = Spin.new
  end

  def edit
  end

  def create
    @spin = @retrospect.spins.build(spin_params)
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
    @retrospect = Retrospect.find(params[:retrospect_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_spin
    @spin = Spin.find(params[:id])
    @retrospect = @spin.retrospect
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def spin_params
    local_params = params.require(:spin).permit(:status, :title, :summary)
    local_params = local_params.merge(user: current_user)
    return local_params
  end

  def broadcast_create_spin(spin)
    html = ApplicationController.render partial: "spins/spin", locals: {current_user: current_user, spin: spin}, formats: [:html]
    ActionCable.server.broadcast "spins", {action: "create", id: "spin-#{spin.id}", html: html}
  end

  def broadcast_delete_spin(spin)
    ActionCable.server.broadcast "spins", {action: "delete", id: "spin-#{spin.id}"}
  end

  def broadcast_update_spin(spin)
    html = ApplicationController.render partial: "spins/spin", locals: {current_user: current_user, spin: spin}, formats: [:html]
    ActionCable.server.broadcast "spins", {action: "update", id: "spin-#{spin.id}", html: html}
  end
end
