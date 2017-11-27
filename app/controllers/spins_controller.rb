class SpinsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_retrospect
  before_action :set_spin, only: [:show, :edit, :update, :destroy]

  def index
    @spins = Spin.where(retrospect_id: params[:retrospect_id]).order('created_at DESC')
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
  end

  def update
    respond_to do |format|
      if @spin.update(spin_params)
        format.json {render :show, status: :ok, location: @spin}
        format.js {render js: '$(".modal").modal("hide");'}
      else
        format.html {render :edit}
        format.json {render json: @spin.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @spin.destroy
    respond_to do |format|
      # format.html { redirect_to spins_url, notice: 'Spin was successfully destroyed.' }
      format.json {head :no_content}
    end
  end

  private
  def set_retrospect
    @retrospect = Retrospect.find(params[:retrospect_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_spin
    @spin = Spin.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def spin_params
    local_params = params.require(:spin).permit(:status, :title, :summary)
    local_params = local_params.merge(user: current_user)
    return local_params
  end
end
