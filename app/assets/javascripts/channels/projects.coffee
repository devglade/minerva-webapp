@MakeRetrospectChannel = (parentId) ->
  App.retrospects = App.cable.subscriptions.create({
    channel: 'ProjectsChannel',
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
          if $('#project-' + data.id).length == 0
            $.get('projects/' + data.id).done (html)->
              $('.create-project').after html
        when 'delete'
          if $('#project' + data.id).length > 0
            $('#project' + data.id).remove()
        when 'update'
          if $('#project-' + data.id).length > 0
            $.get('projects/' + data.id).done (html)->
              $('#project-' + data.id).replaceWith html
        else
          alert(data)
          break
  )
return