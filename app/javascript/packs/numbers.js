$(document).ready( function () {
    var t = $('#numTable').DataTable({"aLengthMenu": [[10, 20, 50, 100, -1], [10, 20, 50, 100, "All"]],
      columnDefs: [
      {
        searchable: false,
          orderable: false,
          targets: [0]
      }],
      order: [[ 1, 'asc' ]],

    });

    t.on( 'order.dt search.dt', function () {
      t.column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
          cell.innerHTML = i+1;
      } );
    } ).draw();

    $('#exampleModal').on('shown.bs.modal', function () {
      $('.assignbutt').trigger('focus')
    })

    // $('#numTable tbody').on( 'click', 'button', function () {
    //     var data = table.row( $(this).parents('tr') ).data();
    //     console.log( data[1] );
    // } );
    // $(document).on('click', '#sendsend', function() {
    // 	$('#form3').submit();
    // });
    $(".student-name").on('change', function() {
      assignNum($(this));
    });
;
});

function assignNum(element) {
  let selected = element.val();
  console.log(selected);

  // $.ajax('/assign_num', {
  //   type: 'GET',
  //   dataType: 'json',
  //   data: {term: selected},
  //   success: function(result) {
  //     console.log('Success');
  //     result.sort(function(a, b) {
  //       return compareStrings(a.department, b.department);
  //     })
  //     $(".department").append("<option value=''>Choose Department</option>");
  //     let used = [];
  //     for (var i = 0; i < result.length; i++) {
  //       if (!(used.includes(result[i].department))) {
  //         $(".department").append("<option>" + result[i].department + "</option>");
  //         used.push(result[i].department);
  //       }
  //     }
  //   },
  //   error: function() {
  //     console.log('Error');
  //   }
  // });
}
