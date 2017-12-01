class SpinsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "spins"
  end

  def unsubscribed
    stop_all_streams
  end
end
