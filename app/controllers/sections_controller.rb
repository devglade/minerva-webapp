class SectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project_spin
  before_action :set_section, only: [:show, :edit, :update, :destroy]

  def new
    @section = Section.new
  end

  def show
  end

  def create
    @spin = Spin.find_by_id(params[:spin_id])
    @section = @spin.sections.build(section_params)

    respond_to do |format|
      if @section.save
        format.html {redirect_to space_project_spin_path(@space, @project, @spin), notice: 'Section was successfully created.'}
        format.json {render :show, status: :created, location: @section}
      else
        format.html {render :new}
        format.json {render json: @section.errors, status: :unprocessable_entity}
      end
    end
  end

  def edit

  end

  def update
    respond_to do |format|
      if @section.update(section_params)
        format.html {redirect_to space_project_spin_path @space, @project, @spin, notice: 'Section was successfully updated.'}
        format.json {render :show, status: :ok, location: @section}
      else
        format.html {render :edit}
        format.json {render json: @section.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @section.destroy
    respond_to do |format|
      format.html do
        redirect_to space_project_spin_path(@space, @project, @spin), notice: 'Section was successfully destroyed.'
      end
      format.json {head :no_content}
    end
  end

  private

  def set_section
    @section = Section.find(params[:id])
  end

  def set_project_spin
    @spin = Spin.find_by_id(params[:spin_id])
    @project = @spin.project
    @space = @project.space
  end

  def section_params
    params.require(:section).permit(:title, :position)
  end
end
