window.Minerva = {}

UTIL =
  exec: (controller, action) ->
    console.log controller + ":" + action
    ns = Minerva
    action = (if (action is `undefined`) then "init" else action)
    ns[controller][action]()  if controller isnt "" and ns[controller] and typeof ns[controller][action] is "function"

  init: ->
    body = document.body
    controller = body.getAttribute("data-controller")
    action = body.getAttribute("data-action")
    UTIL.exec controller, "init"
    UTIL.exec controller, "init_#{action}"

  destroy: ->
    body = document.body
    controller = body.getAttribute("data-controller")
    action = body.getAttribute("data-action")
    UTIL.exec controller, "destroy_#{action}"
    UTIL.exec controller, "destroy"


$(document).ready(UTIL.init);