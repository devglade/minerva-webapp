App.posts = App.cable.subscriptions.create "PostsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel

    switch data.action
      when 'create'
        if $("#board").data("spin") == data.spin_id
          $('#board').prepend data.html
      when 'delete'
        if $('#' + data.id).length > 0
          $('#' + data.id).remove()
      when 'update'
        if $('#' + data.id).length > 0
          $('#' + data.id).replaceWith data.html
      when 'like_dislike'
        if $('#like-' + data.id).length > 0
          $('#like-' + data.id).html '<i class=\"material-icons\">thumb_up</i> '  + data.like + ' '
        if $('#dislike-' + data.id).length > 0
          $('#dislike-' + data.id).html '<i class=\"material-icons\">thumb_down</i> ' + data.dislike + ' '
      else
        break