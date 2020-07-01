$(document).ready(function () {
    var table = $('#myTable').DataTable( {
        columnDefs: [ { orderable: false, targets: [0] } ],
        order: [[ 1, 'asc' ]],
    } );

    $(".accept").on('click', function() {
        var data = table.row( $(this).parents('tr') ).data();
        confirm("Are you sure you want to accept "+ data[0] + "'s request?");
    });

    $(".deny").on('click', function() {
        var data = table.row( $(this).parents('tr') ).data();
        confirm("Are you sure you want to deny "+ data[0] + "'s request?");
    });

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
            '<td>'+d[0]+'</td>'
        '</tr>'+
    '</table>';
}