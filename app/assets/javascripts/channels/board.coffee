App.board
@MakeBoardChannel = (spinId) ->
  if App.board == undefined
    App.board = App.cable.subscriptions.create({
      channel: 'BoardChannel',
      spin_id: spinId
    },
      connected: ->
# Called when the subscription is ready for use on the server
      disconnected: ->
# Called when the subscription has been terminated by the server
      received: (data) ->
        json = JSON.parse(data.payload)
        if spinId == json.spin_id && data.commit
          window.store.commit(data.commit, json)
    )
# Called when there's incoming data on the websocket for this channel
