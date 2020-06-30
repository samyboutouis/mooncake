$(document).ready(function () {
  // var data = JSON.parse(JSON.parse(@json).data);

  $(".question").on('change', function() {
    sort($(this));
  });

});


function sort(element) {
  let selected = element.val();
  $('#answers').empty();
  console.log(selected);
  $.ajax('/facreqview', {
    type: 'GET',
    data: {question_text: selected},
    success: function(result) {
      // $('#answers').load(" #answers>*");
      // location.reload();
      console.log('Success');
      // $('#answers').append(" <% @answer.each do |answer| %>").html_safe;
      // $('#answers').append(" <tr>");
      // $('#answers').append(" <% answer.course_request.answers.each do |answer| %>").htmlerb_safe;
      // $('#answers').append("<td><%= answer.answer_text %></td>").html_safe;
      // $('#answers').append("<% end %>").html_safe;
      // $('#answers').append(" <% @answer.each do |answer| %>").html_safe;
      // $('#answers').append(" </tr>");
      // $('#answers').append(" <% end %>").html_safe;
    },
    error: function() {
      console.log('Error');
    }
  });
}