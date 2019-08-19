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

  $(".select2").select2({
    placeholder: "Select option tags",
    tags: true,
    createTag: function (params) {
      var term = $.trim(params.term);
      if (term === '') {
        return null;
      }
      return {
        id: term,
        text: term,
        newTag: true,
        tokenSeparators: [",", " "]
      }
    }
  }).on("change", function(e) {
    var isNew = $(this).find('[data-select2-tag="true"]');
    if(isNew.length && $.inArray(isNew.val(), $(this).val()) !== -1){
      isNew.replaceWith('<option selected value="' + isNew.val() + '">' + isNew.val() + '</option>');
      $('#console').append('<code>New tag: {"' + isNew.val() + '":"' + isNew.val() + '"}</code><br>');
    }
  });
});
