@MakeSpaceChannel = (parentId) ->
  App.spaces = App.cable.subscriptions.create({
    channel: 'SpacesChannel',
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
          if $('#space-' + data.id).length == 0
            $('#create-button').toggle(data.state)
            $.get('spaces/' + data.id).done (html)->
              console.log(html)
              $('#space-board').prepend html
        when 'delete'
          if $('#' + data.id).length > 0
            $('#create-button').toggle(data.state)
            $('#' + data.id).remove()
        when 'update'
          if $('#space-' + data.id).length > 0
            $.get('spaces/' + data.id).done (html)->
              $('#space-' + data.id).replaceWith html
        else
          alert(data)
          break
  )
return