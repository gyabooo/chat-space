$(function () {
  // build append user HTML
  function buildUserHTML(user) {
    html = `<div class="chat-group-user clearfix">
              <p class="chat-group-user__name">${user.name}</p>
              <div class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.name}">追加</div>
            </div>`;

    return html;
  }
  // build not found user HTML
  function buildNotFoundUserHTML() {
    html = `<div class="chat-group-user clearfix">
              <p class="chat-group-user__name">一致するユーザーが見つかりません</p>
            </div>`;

    return html;
  }
  // build member HTML
  function buildMemberHTML(user) {
    html = `<div class="chat-group-user clearfix js-chat-member" id="chat-group-user-${user.userId}">
              <input multiple="multiple" value="${user.userId}" type="hidden" name="group[user_ids][]" id="group_user_ids">
              <p class="chat-group-user__name">${user.userName}</p>
              <div class="user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn">削除</div>
            </div>`;
    
    return html;
  }

  // run turbolinks event at first load, reload, page switching
  $(document).on('turbolinks:load', function (e) {
    // input variables
    var input;
    var prev_input;
    // ajax variables
    var data;
    var result_box = $('#user-search-result');
    var url = '/users';
    // members id variables
    var members = $("#chat-group-users > .chat-group-user > input");
    var current_user_id = Number($(members[0]).val());
    var current_member_ids = [];
    // get members id
    $.each(members, function (i, user) {
      current_member_ids.push(Number($(user).val()));
    });
    // run keyup event
    $('#user-search-field').on('keyup', function () {
      input = $(this).val();
      // no input
      if (input.length === 0) {
        result_box.empty();
        prev_input = input;
        return false;
      }
      // not change input ex) shift-key command-key etc...
      if (input === prev_input) return false;
      prev_input = input;

      data = { search: input, current_user_id: current_user_id }
      // run ajax
      $.ajax({
        url: url,
        data: data,
        dataType: 'json'
      })
      .done(function (data) {
        result_box.empty();
        // not found search result
        if (data.users.length === 0) {
          result_box.append(buildNotFoundUserHTML());
          return false;
        }
        // append search result
        var is_append = false;
        $.each(data.users, function (index, user) {
          if ($.inArray(user.id, current_member_ids) !== -1) return true;
          result_box.append(buildUserHTML(user));
          is_append = true;
        })
        // search result exists users 
        if (!is_append) {
          result_box.append(buildNotFoundUserHTML());
        }
      })
      .fail(function () {
        alert('ユーザー検索に失敗しました');
      })
    })
    // add user to chat member
    $("#user-search-result").on('click', '.user-search-add', function (e) {
      var user = $(e.currentTarget).data();
      $(e.currentTarget).parent().remove();
      $("#chat-group-users").append(buildMemberHTML(user));
      current_member_ids.push(user.userId);
    })
    // remove user from chat member
    $("#chat-group-users").on('click', '.user-search-remove', function (e) {
      var user_id = Number($(e.currentTarget).siblings("input").val());
      current_member_ids = current_member_ids.filter(v => v !== user_id);
      $(e.currentTarget).parent().remove();
    })
  })

})