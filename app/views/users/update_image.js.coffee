<% if current_user.errors.any? %>
alert("사진을 변경하지 못했습니다.")
<% else %>
<% if @redirect_url %>
window.location.href = '<%= @redirect_url %>';
<% else %>
$('#preview').html '<%= cl_image_tag(current_user.image_id, {width: 100, height: 100, class: 'img-circle setting-profile-picture'}) %>'
$('#dProfile').attr 'src', '<%= cl_image_path(current_user.image_id) %>'
<% end %>
<% end %>
