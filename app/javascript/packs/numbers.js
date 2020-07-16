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
;
});
