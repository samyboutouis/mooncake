$(document).ready(function () {
    var table = $('#myTable').DataTable();

    $(".accept").on('click', function() {
        getAccept($(this));
    });

    $(".deny").on('click', function() {
        var data = table.row( $(this).parents('tr') ).data();
        alert("Deny "+ data[0] + "'s request");
        getDeny($(this));
    });
});

// function getDeny(element) {
//     let selected = element.val();
//     var data = table.row( $(this).parents('tr') ).data();
//     alert( data[0] );
//     // $.ajax('/deny', {
//     //   type: 'GET',
//     //   dataType: 'json',
//     //   data: {department: selected},
//     //   success: function(result) {
//     //     console.log('Success');
//     //     $(".number").append("<option>Choose Course Number</option>");
//     //     for (var i = 0; i < result.length; i++) {
//     //       $(".number").append("<option>" + result[i].course_number + "</option>");
//     //     }
//     //   },
//     //   error: function() {
//     //     console.log('Error');
//     //   }
//     // });
//   }
  
  