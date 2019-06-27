$(function () {
  $('#new_message').on('submit', function (e) {
    e.preventDefault();
    //console.log('OK');
    // create form data
    var formData = new FormData(this);
    var url = $(this).attr('action');
    // debugger;
    $.ajax({
      url: url,
      type: 'POST',
      data: formData,
      processData: false,
      contentType: false,
      dataType: 'json',
    })
    .done(function(data) {
      console.log('OK')
    })
    .fail(function () {
      alert('Fail!!')
    })

  })
})