$(document).ready(function () {
  $(".department").on('change', function() {
    getNumber($(this));
  });

  $(".number").on('change', function() {
    getSection($(this));
  });
});

$(function(){
    var current = location.pathname;
    $('.navbar a').each(function(){
        var $this = $(this);
        // if the current path is like this link, make it active
        if($this.attr('href').indexOf(current) !== -1){
            $this.addClass('active');
        }
    })
})

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
      let used = [];
      for (var i = 0; i < result.length; i++) {
        if (!(used.includes(result[i].course_number))) {
          $(".number").append("<option>" + result[i].course_number + "</option>");
          used.push(result[i].course_number);
        }
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
