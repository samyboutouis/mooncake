$(document).ready(function () {
    var table = $('#numTable').DataTable( {
      columnDefs: [ 
        { 
            orderable: false, 
            targets: [0] 
        }],
      order: [[ 1, 'asc' ]],
    } );
  });
