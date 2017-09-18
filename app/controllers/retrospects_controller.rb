class RetrospectsController < ApplicationController
  before_action :set_retrospect, only: [:show, :edit, :update, :destroy]

  # GET /retrospects
  # GET /retrospects.json
  def index
    @retrospects = Retrospect.all
  end

  # GET /retrospects/1
  # GET /retrospects/1.json
  def show
  end

  # GET /retrospects/new
  def new
    @retrospect = Retrospect.new
  end

  # GET /retrospects/1/edit
  def edit
  end

  # POST /retrospects
  # POST /retrospects.json
  def create
    @retrospect = Retrospect.new(retrospect_params)

    respond_to do |format|
      if @retrospect.save
        format.html { redirect_to @retrospect, notice: 'Retrospect was successfully created.' }
        format.json { render :show, status: :created, location: @retrospect }
      else
        format.html { render :new }
        format.json { render json: @retrospect.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /retrospects/1
  # PATCH/PUT /retrospects/1.json
  def update
    respond_to do |format|
      if @retrospect.update(retrospect_params)
        format.html { redirect_to @retrospect, notice: 'Retrospect was successfully updated.' }
        format.json { render :show, status: :ok, location: @retrospect }
      else
        format.html { render :edit }
        format.json { render json: @retrospect.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /retrospects/1
  # DELETE /retrospects/1.json
  def destroy
    @retrospect.destroy
    respond_to do |format|
      format.html { redirect_to retrospects_url, notice: 'Retrospect was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_retrospect
      @retrospect = Retrospect.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def retrospect_params
      params.require(:retrospect).permit(:name, :description, :user_id)
    end
end
