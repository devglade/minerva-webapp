@MakeRetrospectChannel = (parentId) ->
  App.retrospects = App.cable.subscriptions.create({
    channel:  'RetrospectsChannel',
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
          if $('#retrospect-' + data.id).length == 0
            $.get('retrospects/'+ data.id).done (html)->
             $('.retrospect-list-group').prepend html
        when 'delete'
          if $('#' + data.id).length > 0
            $('#' + data.id).remove()
        when 'update'
          if $('#retrospect-' + data.id).length > 0
            $.get('retrospects/'+ data.id).done (html)->
              $('#retrospect-' + data.id).replaceWith html
        else
          alert(data)
          break
  )
return