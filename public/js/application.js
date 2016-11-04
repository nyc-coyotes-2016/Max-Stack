$(document).ready(function() {
    $(".answer_list").on('click', '#add_answer_existing', function(event){
        event.preventDefault();
        var route = $(this).attr('href');
        $.ajax({
          url: route,
          type: 'GET'
        }).done(function(response) {
          // alert(response);
          $('.answer-button-unique').append(response);
        });
      });

    $(".answer_list").on('submit', '.new-user-answer-form', function(event) {
      event.preventDefault();
      var form = $(this).find('form')[0];
      var route = $(form).attr('action');
      var type = $(form).attr('method');
      var data = $(form).serialize();
      $.ajax({
        url: route,
        type: type,
        data: data
      }).done(function(response) {
        $('.answer-list-ul').append(response);
        $(form).hide();
      });
    })

    $(".answer_list").on('click', '.edit-link', function(event) {
      event.preventDefault();
      var route = $(this).attr('href');
      $.ajax({
        url: route,
        type: 'GET'
      }).done(function(response) {
        $('.new-user-answer-form').prepend(response);
      })

    })

    $(".answer_list").on('submit', '.delete_answer', function(event) {
      event.preventDefault();
      var route = $(this).attr('action');
      $.ajax({
        url: route,
        type: 'DELETE'
      }).done(function(response) {
        console.log(response.id);
        console.log(typeof response.id)
        $('#answer' + response.answer_id).remove();
      })
    })

});
