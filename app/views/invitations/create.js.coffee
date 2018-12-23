<% if @invitation.errors.empty? %>
$(".modal").modal('hide');
<% else %>
alert("초대하지 못했습니다. 다시 시도해주세요.")
<% end %>