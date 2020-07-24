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
    let label = $('<label/>',
    {
      text: 'How many options would you like?'
    });
    let input = $('<input/>',
    {
      id: "number-choice",
      min: '0',
      max: '20',
      class: 'form-control',
      maxLength: "2",
      required: true
    });
    $("#question-choice").append(label);
    $("#question-choice").append(input);
  }
  else {
    return;
  }
}

function getOptions(element) {
  let selected = element.val();
  $("#question-options").empty();
  for(let i = 0; i < selected; i++) {
    let label = $('<label/>',
    {
      for: "question_option[]",
      text: "Option " + (i + 1) + ":"
    });
    let input = $('<input/>',
    {
      name: "question[option][]",
      type: "text",
      id: "question_option",
      class: 'form-control',
      required: true
    });
    let br = $('<br>');
    $("#question-options").append(label);
    $("#question-options").append(input);
    $("#question-options").append(br);
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