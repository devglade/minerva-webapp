App.spins = App.cable.subscriptions.create "SpinsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    switch data.action
      when 'create'
        if $(".container").data("retrospect") == data.retrospect_id
          $('#spin-board').prepend data.html
      when 'delete'
        if $('#' + data.id).length > 0
          $('#' + data.id).remove()
      when 'update'
        if $('#' + data.id).length > 0
          $('#' + data.id).replaceWith data.html
      else
        alert(data)
        break