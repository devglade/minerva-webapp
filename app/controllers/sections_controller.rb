class SectionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @section = Section.new
  end

end
