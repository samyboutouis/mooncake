$(document).ready(function(){
  $("#question_question_type").on('change', function() {
    getQuestion($(this));
    $("#number-choice").on('change', function() {
      getOptions($(this));
    })
  });
});

function getQuestion(element) {
  let selected = element.val();
  $("#question-choice").empty();
  if (selected === "Text") {
    return;
  }
  else if (selected === "Checkbox" || selected === "Radio") {
    $("#question-choice").append("<label>How many options would you like?</label>");
    $("#question-choice").append('<input type="text" id="number-choice">');
  }
  else {
    return;
  }
}

function getOptions(element) {
  let selected = element.val();
  $("#question-options").empty();
  for(let i = 0; i < selected; i++) {
    $("#question-options").append("<label>Option " + (i + 1) + ":</label>");
    $("#question-options").append('<input type="text" id="option-text"><br>');
  }
}

// $.ajax('/options', {
  //   type: 'GET',
  //   dataType: 'json',
  //   data: {question_type: selected},
  //   success: function(result) {
  //     console.log(result.question_type);
  //     if (selected === "Text") {
  //       return;
  //     }
  //     else if (selected === "Checkbox" || selected === "Radio") {
  //       $("#question-choice").append("<label>How many options would you like?</label>");
  //       $("#question-choice").append('<input type="text" id="number-choice">');
  //     }
  //     else {
  //       return;
  //     }
  //   },
  //   error: function() {
  //     console.log('Error');
  //   }
  // });