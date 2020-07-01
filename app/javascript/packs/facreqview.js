$(document).ready(function () {
    var table = $('#myTable').DataTable();

    $(".accept").on('click', function() {
        var data = table.row( $(this).parents('tr') ).data();
        confirm("Are you sure you want to accept "+ data[0] + "'s request?");
    });

    $(".deny").on('click', function() {
        var data = table.row( $(this).parents('tr') ).data();
        confirm("Are you sure you want to deny "+ data[0] + "'s request?");
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
  
  