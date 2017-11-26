<% if user_signed_in? %>
$(document).on 'hidden.bs.modal', '.modal', -> $(this).remove()

$('<%= j render 'form', locals: {spin: @spin} %>').on('submit', (e) ->

).modal('toggle')
<% else %>
alert '로그인하세요'
<% end %>