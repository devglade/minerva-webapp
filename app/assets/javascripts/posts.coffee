# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('[data-toggle="popover"]').popover()

  dragMoveListener = (event) ->
    console.log(event)
    target = event.target
    x = (parseFloat(target.getAttribute('data-x')) or 0) + event.dx
    y = (parseFloat(target.getAttribute('data-y')) or 0) + event.dy
    # translate the element
    target.style.webkitTransform = target.style.transform = 'translate(' + x + 'px, ' + y + 'px)'
    # update the posiion attributes
    target.setAttribute 'data-x', x
    target.setAttribute 'data-y', y
    return

  interact('.draggable').draggable
    inertia: true
    restrict:
      restriction: 'parent'
      endOnly: true
      elementRect:
        top: 0
        left: 0
        bottom: 1
        right: 1
    autoScroll: true
    onmove: dragMoveListener
    onend: (event) ->
#      textEl = event.target.querySelector('p')
#      textEl and (textEl.textContent = 'moved a distance of ' + Math.sqrt((event.pageX - (event.x0)) ** 2 + (event.pageY - (event.y0)) ** 2 | 0).toFixed(2) + 'px')
      return
  # this is used later in the resizing and gesture demos
  window.dragMoveListener = dragMoveListener