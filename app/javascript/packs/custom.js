$(document).ready(function () {
  $(".term").on('change', function() {
    getDepartment($(this));
  });

  $(".department").on('change', function() {
    getNumber($(this));
  });

  $(".number").on('change', function() {
    getSection($(this));
  });
  //fac index modal
  $('#facModal').on('shown.bs.modal', function () {
  $('#factut').trigger('focus')

})
  $(".help").on('click', function() {
    excelPop();
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

function getDepartment(element) {
  let selected = element.val();
  $(".department").empty();
  console.log
  $.ajax('/term', {
    type: 'GET',
    dataType: 'json',
    data: {term: selected},
    success: function(result) {
      console.log('Success');
      result.sort(function(a, b) {
        return compareStrings(a.department, b.department);
      })
      $(".department").append("<option value=''>Choose Department</option>");
      let used = [];
      for (var i = 0; i < result.length; i++) {
        if (!(used.includes(result[i].department))) {
          $(".department").append("<option>" + result[i].department + "</option>");
          used.push(result[i].department);
        }
      }
    },
    error: function() {
      console.log('Error');
    }
  });
}

function getNumber(element) {
  let department = element.val();
  let term = $(".term").val();
  $(".number").empty();
  $.ajax('/department', {
    type: 'GET',
    dataType: 'json',
    data: {department: department, term: term},
    success: function(result) {
      result.sort(function(a, b) {
        return compareStrings(a.department, b.department);
      })
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
  let term = $(".term").val();
  $(".section").empty();
  $.ajax('/section', {
    type: 'GET',
    dataType: 'json',
    data: {course_number: courseNumber, department: department, term: term},
    success: function(result) {
      result.sort(function(a, b) {
        return compareStrings(a.department, b.department);
      })
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

function compareStrings(a, b) {
  // Assuming you want case-insensitive comparison
  a = a.toLowerCase();
  b = b.toLowerCase();

  return (a < b) ? -1 : (a > b) ? 1 : 0;
}


function excelPop() {
  var popup = document.getElementById("myPopup");
  popup.classList.toggle("show");
}
