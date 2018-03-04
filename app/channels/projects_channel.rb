class ProjectsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "#{params[:parentId]}_projects"
  end

  def unsubscribed
    stop_all_streams
  end
end
