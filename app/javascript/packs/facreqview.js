$(document).ready(function () {
  // var data = JSON.parse(JSON.parse(@json).data);



  $(".question").on('change', function() {
    getNumber($(this));
  });

});


function getNumber(element) {
  let selected = element.val();
  $.ajax('/facreqview', {
    type: 'GET',
    dataType: 'json',
    data: {question_text: selected},
    success: function(result) {
      console.log('Success');
    },
    error: function() {
      console.log('Error');
    }
  });
}