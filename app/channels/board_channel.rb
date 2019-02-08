class BoardChannel < ApplicationCable::Channel
  def subscribed
    stream_from "board_#{params[:spin_id]}"
  end

  def unsubscribed
    stop_all_streams
  end
end
