function previewFile() {
  var preview = document.querySelector('img.cover-image-upload');
  var file    = document.querySelector('input[type=file]').files[0];
  var reader  = new FileReader();

  reader.addEventListener("load", function () {
    preview.src = reader.result;
  }, false);

  if (file) {
    reader.readAsDataURL(file);
  }
}

$(document).ready(function () {
  $(".file").on('change', function(){
     var fileprop = $(this).prop('files')[0],
         find_img = $(this).parent().find('img'),
         filereader = new FileReader(),
         view_box = $(this).parent('.view_box');

    if(find_img.length){
       find_img.nextAll().remove();
       find_img.remove();
    }

    var img = '<div class="img_view"><img alt="" class="img"><p><a href="#" class="img_del">画像を削除する</a></p></div>';

    view_box.append(img);

    filereader.onload = function() {
      view_box.find('img').attr('src', filereader.result);
      img_del(view_box);
    }
    filereader.readAsDataURL(fileprop);
  });

  function img_del(target){
    target.find("a.img_del").on('click',function(){
      var self = $(this),
          parentBox = self.parent().parent().parent();
      if(window.confirm('画像を削除します。\nよろしいですか？')){
        setTimeout(function(){
          parentBox.find('input[type=file]').val('');
          parentBox.find('.img_view').remove();
        } , 0);
      }
      return false;
    });
  }

});

$(function(){
  function buildHTML(user){
    var html = `<div class="chat-group-user clearfix">
                  <p class="chat-group-user__name"> ${user.name} </p>
                  <a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.name}">追加</a>
                </div>`
    return html;
  }
  $(document).on('turbolinks:load', function(){
    $(document).on('keyup', '#user-search-field', function(e){
      e.preventDefault();
      var input = $.trim($(this).val());
      $.ajax({
        url: '/tags/search',
        type: 'GET',
        data: ('keyword=' + input),
        processData: false,
        contentType: false,
        dataType: 'json'
      })
      .done(function(data){
        $(data).each(function(i, user){
          $('#user-search-result').find('div').remove();
          var html = buildHTML(user);
          $('#user-search-result').append(html);
        })
      })
      .fail(function(){
        alert('error');
      });
    });
  });
});

$(document).on('turbolinks:load', function(){
  function buildHTML(data_name, data_id){
    var html = `<div class='chat-group-user clearfix js-chat-member' id='chat-group-user-${data_id}'>
                  <input name='prototype[tag_ids][]' type='hidden' value='${data_id}'>
                  <p class='chat-group-user__name'> ${data_name} </p>
                  <a class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn' data-user-id="${data_id}">削除</a>
                </div>`
    return html;
  }
  $('#user-search-result').on('click', '.user-search-add', function(e){
    e.preventDefault();
   var data_name = $(this).data('userName');
   var data_id = $(this).data('userId');
      var html = buildHTML(data_name, data_id);
      $('.chat-group-user__name1').append(html);
      $('#user-search-result').find('div').remove();
  });
});

$(document).on('turbolinks:load', function(){
  $('.chat-group-user__name1').on('click', '.user-search-remove', function(e){
    e.preventDefault();
    $('.chat-group-user__name1').find('#chat-group-user-' + $(this).data('userId')).remove();
  });
});

