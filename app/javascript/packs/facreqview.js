$(document).ready(function () {
    var table = $('#myTable').DataTable( {
        columnDefs: [ { orderable: false, targets: [0] } ],
        order: [[ 1, 'asc' ]],
    } );

    $('#myTable tbody').on('click', 'td.details-control', function () {
        var tr = $(this).closest('tr');
        var row = table.row( tr );
    
        if ( row.child.isShown() ) {
            // This row is already open - close it
            row.child.hide();
            tr.removeClass('shown');
        }
        else {
            // Open this row
            row.child( format(row.data()) ).show();
            tr.addClass('shown');
        }
    } );
});

function format ( d ) {
    // `d` is the original data object for the row
    
    return '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">'+
        '<tr>'+
            '<td>Full name:</td>'+
            '<td>'+d[0]+'</td>'+
        '</tr>'+
    '</table>';
}