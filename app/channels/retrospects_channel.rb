class RetrospectsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "#{params[:parentId]}_retrospects"
  end

  def unsubscribed
    stop_all_streams
  end
end
