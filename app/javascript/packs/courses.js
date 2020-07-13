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

  $(".custom-file-input").on("change", function() {
    var fileName = $(this).val().split("\\").pop();
    $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
  }); 
});



function createField() {
    count++;
    var clonedField = $(".prereqfield:first").clone();
    clonedField.attr("name", "prereq_attributes["+ count + "]name" );
    clonedField.appendTo(".addNew");
}


function getQuestion(element) {
  let selected = element.val();
  $("#question-choice").empty();
  if (selected === "Checkbox" || selected === "Radio") {
    $("#question-choice").append("<label>How many options would you like?</label>");
    $("#question-choice").append('<input type="text" id="number-choice" maxlength= 2>');
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
    $("#question-options").append('<input name= "question[option][]" type="text" id="question_option"><br>');
  }
}