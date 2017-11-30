class RetrospectsController < ApplicationController
  before_action :set_retrospect, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @retrospects = Retrospect.all.order('created_at DESC')
  end

  def show
  end

  def new
    @retrospect = Retrospect.new
  end

  def edit
  end

  def create
    @retrospect = Retrospect.new(retrospect_params.merge(user_id: current_user.id))
    @retrospect.save
  end

  # PATCH/PUT /retrospects/1
  # PATCH/PUT /retrospects/1.json
  def update
    @retrospect.update_attributes(retrospect_params)
  end

  # DELETE /retrospects/1
  # DELETE /retrospects/1.json
  def destroy
    @retrospect.destroy
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

end
