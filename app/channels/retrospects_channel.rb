class RetrospectsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "retrospects"
  end

  def unsubscribed
    stop_all_streams
  end
end
