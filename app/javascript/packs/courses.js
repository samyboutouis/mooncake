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

  $("#customFile").on('change', function() {
    if (!(validate($(this)))) {
      if ($('.invalid-feedback').length == 0) {
        $('.custom-file').append('<div class="invalid-feedback">You uploaded an invalid file. You can only upload an excel file from DukeHub.</div>');
      }
      $(this).addClass('is-invalid');
      $("#customFile").replaceWith($("#customFile").val('').clone(true));
    }
    else {
      $(".invalid-feedback").remove();
      $(this).css('background-color', 'white');
    }
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

function validate(file) {
  var allowed_extensions = new Array("xlsx","xls","csv");
  var file_extension = file.val().split('.').pop().toLowerCase();
  for(var i = 0; i <= allowed_extensions.length; i++)
  {
      if(allowed_extensions[i]==file_extension)
      {
          return true; // valid file extension
      }
  }
  return false;
}