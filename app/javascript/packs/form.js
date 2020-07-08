$(document).ready(function(){
  $("#crosslisting").on('input', function() {
    getResponse($(this));
    $("#number-choice").on('input', function() {
      getOptions($(this));
    })
  });
});

function getResponse(element) {
  let selected = element.val();
  $("#howmany").empty();
  if (selected === "Yes") {
    $("#howmany").append("<label for= 'number-choice'>How many courses are cross-listed?</label>");
    $("#howmany").append('<input type="text" name= "number-choice" id="number-choice" maxlength= 2><br>');
  }
  else {
    return;
  }
}

function getOptions(element) {
  let selected = element.val();
  $("#othercourses").empty();
  for(let i = 0; i < selected; i++) {
    $("#othercourses").append("<h3> Cross-listed Course " + (i+1) + "</h3>");
    $("#othercourses").append("<label for= 'department"+(i+1)+"'> Deparment:</label>");
    $("#othercourses").append('<input name= "department'+(i+1)+'" type="text" id="department'+(i+1)+'"><br>');

    $("#othercourses").append("<label for= 'course_number"+(i+1)+"'> Course Number:</label>");
    $("#othercourses").append('<input name= "course_number'+(i+1)+'" type="text" id="course_number'+(i+1)+'"><br>');

    $("#othercourses").append("<label for= 'section_number"+(i+1)+"'> Section Number:</label>");
    $("#othercourses").append('<input name= "section_number'+(i+1)+'" type="text" id="section_number'+(i+1)+'"><br>');

    $("#othercourses").append("<label for= 'file"+(i+1)+"'> Upload Permission Numbers CSV File</label>");
    $("#othercourses").append('<input name= "file'+(i+1)+'" type="file" id="file'+(i+1)+'"><br>');
  }
}