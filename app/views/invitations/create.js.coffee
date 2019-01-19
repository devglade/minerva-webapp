<% if @exist_member %>
alert("<%= @space_name %>공간에 참여하고 있는 사람입니다.")
<% elsif @invitation.errors.empty? %>
$(".modal").modal('hide');
<% else %>
alert("초대하지 못했습니다. 다시 시도해주세요.")
<% end %>