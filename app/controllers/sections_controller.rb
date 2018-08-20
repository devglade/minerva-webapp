class SectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project_spin

  def new
    @section = Section.new
  end

  def create
    @spin = Spin.find_by_id(params[:spin_id])
    @section = @spin.sections.build(section_params)

    respond_to do |format|
      if @section.save
        format.html {redirect_to space_project_spin_path(@space, @project, @spin), notice: 'List was successfully created.'}
        format.json {render :show, status: :created, location: @section}
      else
        format.html {render :new}
        format.json {render json: @section.errors, status: :unprocessable_entity}
      end
    end
  end

  private

  def set_project_spin
    @spin = Spin.find_by_id(params[:spin_id])
    @project = @spin.project
    @space = @project.space
  end

  def section_params
    params.require(:section).permit(:title, :position)
  end
end
