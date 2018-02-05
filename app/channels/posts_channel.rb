class PostsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "#{params[:parentId]}_posts"
  end

  def unsubscribed
    stop_all_streams
  end
end
