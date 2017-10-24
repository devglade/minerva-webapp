<% if user_signed_in? %>
$('<%= j render 'detail', locals: {post: @post} %>').on('submit', (e) ->

).modal('toggle')
<% else %>
alert '로그인하세요'
<% end %>