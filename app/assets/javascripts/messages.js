$(function () {

  // return image html
  function image_html(data) {
      return `<img src="${data.image.url}" alt="${data.image_alt}">`;
  }

  // return image thumb html
  function image_thumb_html(data) {
    return `<img src="${data.image.thumb.url}" alt="${data.image_thumb_alt}">`;
  }

  // return main contents html
  function buildMainHTML(data) {
    html = `<div class="chat-message-container">
              <div class="chat-message__info">
                <p class="chat-message__username">${data.username}</p>
                <p class="chat-message__date">${data.date}</p>
              </div>
              <div class="chat-message__message">
                <p>${data.message}</p>
                ${data.image.url ? image_html(data) : ''}
              </div>
            </div>`;
    
    return html;
  }

  // return side contents html
  function buildSideHTML(data) {
    var html = `<div class="chat-group__info">`;
    if (data.message) {
      html = html + `${data.message} `
    }
    if (data.image.url) {
      html = html + `${image_thumb_html(data)}`
    }
    return html + `</div>`
  }

  // return current chose group on sidebar for jquery
  function getCurrentSideGroup(url) {
    var chat_groups = $(".chat-group a");
    for (var i = 0; i < chat_groups.length; i++){
      if ($(chat_groups[i]).attr('href') === url) return $(chat_groups[i]);
    }
  }

  // run turbolinks event at first load, reload, page switching
  $(document).on('turbolinks:load', function () {
    // run ajax
    $('#new_message').on('submit', function (e) {
      e.preventDefault();

      var formData = new FormData(this);
      var url = $(this).attr('action');

      $.ajax({
        url: url,
        type: 'POST',
        data: formData,
        dataType: "json",
        processData: false,
        contentType: false
      })
      .done(function (data) {
        // update main contents
        $(".contents__chat-messages")
          .append(buildMainHTML(data))
          .animate({ scrollTop: $(".contents__chat-messages")[0].scrollHeight });
        $("#message_body").val('');
        $('#message_image').val('');
        $(".chat-form__btn").prop("disabled", false);
        // update sidebar
        var side_group = getCurrentSideGroup(url);
        side_group.find(".chat-group__info").remove();
        side_group.append(buildSideHTML(data));
      })
      .fail(function () {
        alert('メッセージの送信に失敗しました');
        $(".chat-form__btn").prop("disabled", false);
      })

    })
  })

})