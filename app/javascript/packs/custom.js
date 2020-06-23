$(document).ready(function () {
  $(".request-box").on('click', function() {
    console.log('clicked');
    let box = $(this);
    let course = $(this).children(".course").text();
    let department = course.split(" ")[0];
    let number = course.split(" ")[1];
    console.log(`${department} ${number}`);
    $.ajax('/request', {
      type: 'GET',
      dataType: 'json',
      data: {department: department, number: number},
      success: function(result) {
        console.log('Success');
        $(box).append(result[0].status)
      },
      error: function() {
        console.log('Error');
      }
    });
  });

  $(".department").change(function() {
    let selected = $(this).val();
    $(".section").empty();
    $.ajax('/department', {
      type: 'GET',
      dataType: 'json',
      data: {department: selected},
      success: function(result) {
        console.log('Success');
        $(".section").append("<option>Choose Course Number</option>");
        for (var i = 0; i < result.length; i++) {
          $(".section").append("<option>" + result[i].course_number + "</option>");
        }
      },
      error: function() {
        console.log('Error');
      }
    });
  }) 
})
/*

$(document).ready(function(){
  $("button").click(function(){
    $("#div1").load("demotext.txt");
  });
});
*/
