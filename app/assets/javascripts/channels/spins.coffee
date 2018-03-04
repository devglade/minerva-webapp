@MakeSpinChannel = (parentId) ->
  App.spins = App.cable.subscriptions.create({
    channel: 'SpinsChannel',
    parentId: parentId
  },
    connected: ->
  # Called when the subscription is ready for use on the server

    disconnected: ->
  # Called when the subscription has been terminated by the server

    received: (data) ->
  # Called when there's incoming data on the websocket for this channel
      switch data.action
        when 'create'
          if $(".container").data("retrospect") == data.project_id && $('#spin-' + data.id).length == 0
            $.get('/spins/'+ data.id).done (html)->
              $('#spin-board').prepend html
        when 'delete'
          if $('#spin-' + data.id).length > 0
            $('#spin-' + data.id).remove()
        when 'update'
          if $('#spin-' + data.id).length > 0
            $.get('/spins/'+ data.id).done (html)->
              $('#spin-' + data.id).replaceWith html
        else
          alert(data)
          break
  )
return