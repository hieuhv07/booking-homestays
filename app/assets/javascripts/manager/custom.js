function readURL(f, previewId) {
  if (f.files && f.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $(previewId)
        .attr('src', e.target.result);
    };
    reader.readAsDataURL(f.files[0]);
  }
}

$(document).ready(function(){
  $('#admin_table').DataTable({
    scrollY: 500,
    "order": [[ 0, 'DESC' ]],
    "pageLength": 25,
    "columnDefs": [
      { "orderable": false, "targets": [5] },
    ]
  });

  $(".dropdown-btn").click( function(e) {
    $(this).toggleClass('active');
    var dropdownContent = $(this).next();
    if (dropdownContent.css('display') === 'block') {
      dropdownContent.css('display', 'none');
    } else {
      dropdownContent.css('display', 'block');
    }
  });

  $('#new_address_modal, #editModal').on('hidden.bs.modal', function(){
    location.reload();
  });

  $('#new-areas').submit(function(){
    $.ajax({
      url: $(this).attr('action'),
      type: $(this).attr('method'),
      data: $(this).serialize(),
      success: function(data) {
        if(data.type == 'success') {
          $('.name_area').val('');
          toastr.success('', data.message);
          $('.load-areas').load(location.href + ' .load-areas');
        } else {
          toastr.error('', data.message);
        }
      }
    });
    return false;
  });

  $('#new-address').submit(function(){
    $.ajax({
      url: $(this).attr('action'),
      type: $(this).attr('method'),
      data: $(this).serialize(),
      success: function(data) {
        if(data.type == 'success') {
          $('.name_address').val('');
          toastr.success('', data.message);
          $('.load-address').load(location.href + ' .load-address');
        } else {
          toastr.error('', data.message);
        }
      }
    });
    return false;
  });

  $('#edit-address').submit(function(){
    $.ajax({
      url: $(this).attr('action'),
      type: 'PATCH',
      data: $(this).serialize(),
      success: function(data) {
        if(data.type == 'success') {
          toastr.success('', data.message);
          $('.load-address').load(location.href + ' .load-address');
        } else {
          toastr.error('', data.message);
        }
      }
    });
    return false;
  });

  $('.address-edit').click(function() {
    $('.name_address').val($(this).data('address-name'))
    $('#edit-address').attr('action', $(this).data('address-url'))
  })
});
