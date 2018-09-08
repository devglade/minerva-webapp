Minerva.registrations =
  init_edit: ->
    $('.cloudinary-fileupload').cloudinary_fileupload {
      dropZone: "#preview"
      maxFileSize: 2048
      acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i
      start: (e) ->
#        console.log "starting..."
        #todo 프로그래스바 보이게해야함;;
      progress: (e, data) ->
#        console.log "uploading..." + Math.round((data.loaded * 100.0) / data.total) + "%"
      fail: (e, data) ->
        alert('사진을 업로드하지 못했습니다.')
    }

    $('.cloudinary-fileupload').bind 'cloudinarydone', (e, data) ->
      $.post(window.location.origin + '/user/update_image', {
        'image_id': data.result.public_id,
        '_method': 'put'
      })