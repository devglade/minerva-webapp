class SpacesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "#{params[:parentId]}_spaces"
  end

  def unsubscribed
    stop_all_streams
  end
end
