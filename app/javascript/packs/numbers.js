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
});

