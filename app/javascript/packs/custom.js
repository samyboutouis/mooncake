$(document).ready(function () {
  $(".department").on('change', function() {
    getNumber($(this));
  });

  $(".number").on('change', function() {
    getSection($(this));
  });
});

function getNumber(element) {
  let selected = element.val();
  $(".number").empty();
  $.ajax('/department', {
    type: 'GET',
    dataType: 'json',
    data: {department: selected},
    success: function(result) {
      console.log('Success');
      $(".number").append("<option value=''>Choose Course Number</option>");
      for (var i = 0; i < result.length; i++) {
        $(".number").append("<option>" + result[i].course_number + "</option>");
      }
    },
    error: function() {
      console.log('Error');
    }
  });
}

function getSection(element) {
  let courseNumber = element.val();
  let department = $(".department").val();
  $(".section").empty();
  $.ajax('/section', {
    type: 'GET',
    dataType: 'json',
    data: {course_number: courseNumber, department: department},
    success: function(result) {
      console.log('Success');
      $(".section").append("<option value=''>Choose Section Number</option>");
      for (var i = 0; i < result.length; i++) {
        $(".section").append("<option>" + result[i].section_number + "</option>");
      }
    },
    error: function() {
      console.log('Error');
    }
  });
}





/*

$(document).ready(function(){
  $("button").click(function(){
    $("#div1").load("demotext.txt");
  });
});
*/
