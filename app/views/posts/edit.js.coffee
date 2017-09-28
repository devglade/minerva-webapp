<% if user_signed_in? %>
$('<%= j render 'form', locals: {post: @post} %>').modal('toggle')
<% else %>
alert '로그인하세요'
<% end %>