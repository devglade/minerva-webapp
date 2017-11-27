class SpinsController < ApplicationController
  before_action :set_spin, only: [:show, :edit, :update, :destroy]

  # GET /spins
  # GET /spins.json
  def index
    @spins = Spin.where(retrospect_id: params[:retrospect_id]).order('created_at DESC')
  end

  # GET /spins/1
  # GET /spins/1.json
  def show
  end

  # GET /spins/new
  def new
    @spin = Spin.new
  end

  # GET /spins/1/edit
  def edit
  end

  # POST /spins
  # POST /spins.json
  def create
    @spin = Spin.new(spin_params)

    respond_to do |format|
      if @spin.save
        format.json { render :show, status: :created, location: @spin }
        format.js { render js: '$(".modal").modal("hide");' }
      else
        format.html { render :new }
        format.json { render json: @spin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spins/1
  # PATCH/PUT /spins/1.json
  def update
    respond_to do |format|
      if @spin.update(spin_params)
        format.json { render :show, status: :ok, location: @spin }
        format.js { render js: '$(".modal").modal("hide");' }
      else
        format.html { render :edit }
        format.json { render json: @spin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spins/1
  # DELETE /spins/1.json
  def destroy
    @spin.destroy
    respond_to do |format|
      # format.html { redirect_to spins_url, notice: 'Spin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spin
      @spin = Spin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def spin_params
      params.require(:spin).permit(:status, :title, :summary)
    end
end
