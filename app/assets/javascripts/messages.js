$(function () {
  var reload_timer;

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
    html = `<div class="chat-message-container" data-id="${data.id}">
              <div class="chat-message__info">
                <p class="chat-message__username">${data.username}</p>
                <p class="chat-message__date">${data.date}</p>
              </div>
              <div class="chat-message__message">
                ${data.message ? '<p>' + data.message + '</p>' : ''}
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

  var reloadMessages = function (current_url) {
    // get group id
    var group_id = current_url.match(/\d+/);
    //カスタムデータ属性を利用し、ブラウザに表示されている最新メッセージのidを取得
    var last_message_id = $($(".chat-message-container:last-child")[0]).data('id');
    var api_url = `/groups/${group_id}/api/messages`;
    $.ajax({
      //ルーティングで設定した通りのURLを指定
      url: api_url,
      //ルーティングで設定した通りhttpメソッドをgetに指定
      type: 'get',
      dataType: 'json',
      //dataオプションでリクエストに値を含める
      data: { id: last_message_id, group_id: group_id }
    })
      .done(function (messages) {
        if (messages.length === 0) return false;
        //追加するHTMLの入れ物を作る
        var insertHTML = '';
        //配列messagesの中身一つ一つを取り出し、HTMLに変換したものを入れ物に足し合わせる
        var latest_message;
        $.each(messages, function (i, message) {
          insertHTML += buildMainHTML(message);
          if (latest_message === undefined) {
            latest_message = message;
            return true
          }
          if (message.id > latest_message.id) latest_message = message;
        })

        //メインメッセージを追加
        var message_contents = $(".contents__chat-messages");
        message_contents
          .append(insertHTML)
          .animate({ scrollTop: message_contents[0].scrollHeight });

        //サイドメッセージを更新
        var side_group = getCurrentSideGroup(current_url);
        side_group.find(".chat-group__info").remove();
        side_group.append(buildSideHTML(latest_message));
      })
      .fail(function () {
        alert('メッセージ自動取得に失敗しました');
      });

  };

  // run turbolinks event at first load, reload, page switching
  $(document).on('turbolinks:load', function (e) {
    var current_url = location.pathname;

    // run ajax
    $('#new_message').on('submit', function (e) {
      e.preventDefault();

      var formData = new FormData(this);
      var url = current_url;
      var message_contents = $(".contents__chat-messages");

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
        message_contents
          .append(buildMainHTML(data))
          .animate({ scrollTop: message_contents[0].scrollHeight });
        $('#new_message')[0].reset();
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

    var regex = new RegExp("/groups/\\d+/messages");
    // clear timer
    if (reload_timer) clearInterval(reload_timer);
    // set timer only messages list page
    if (current_url.match(regex)) {
      reload_timer = setInterval(reloadMessages, 5000, current_url);
    }

  })

})