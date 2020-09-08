const BYTE_UNIT = 1024;
const MAX_SIZE_IMAGE = 5;

$('#micropost_image').bind('change', function () {
  var size_in_megabytes = this.files[0].size/ BYTE_UNIT / BYTE_UNIT;
  if (size_in_megabytes > MAX_SIZE_IMAGE) {
    alert(I18n.t('.alert_image_size'))
    $('#micropost_image').val(null);
  }
});
