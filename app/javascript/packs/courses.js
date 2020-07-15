var count = 0;
$(document).ready(function () {

  $("#add-prereq").on('click', function() {
    createField();
  });

  $("#question_question_type").on('input', function() {
    getQuestion($(this));
    $("#number-choice").on('input', function() {
      getOptions($(this));
    })
  });
});

function createField() {
  count++;
  var clonedField = $(".prereqfield:first").clone();
  clonedField.attr("name", "prereq_attributes["+ count + "]name");
  clonedField.attr("id", "prereq*"+count+"*");
  clonedField.appendTo(".addNew");
  var button = $('<button/>',
  {
      text: '-',
      class: "btn btn-outline-danger",
      style: "margin: 0px 0px 10px 5px",
      click: function () {
        $(this).prev().remove();
        $(this).remove();
      }
  });
  $(".addNew").append(button);
}

function getQuestion(element) {
  let selected = element.val();
  $("#question-choice").empty();
  $("#question-options").empty();
  if (selected === "Checkbox" || selected === "Radio") {
    $("#question-choice").append("<label>How many options would you like?</label>");
    $("#question-choice").append('<input type="number" id="number-choice" max=20 class="form-control">');
  }
  else {
    return;
  }
}

function getOptions(element) {
  let selected = element.val();
  $("#question-options").empty();
  for(let i = 0; i < selected; i++) {
    $("#question-options").append("<label for= 'question_option[]'>Option " + (i + 1) + ":</label>");
    $("#question-options").append('<input name= "question[option][]" type="text" class="form-control" id="question_option"><br>');
  }
}