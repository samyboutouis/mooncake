$(document).ready(function () {
    var table = $('#myTable').DataTable( {
        columnDefs: [ 
            { 
                orderable: false, 
                targets: [0] 
            }],
        order: [[ 1, 'asc' ]],
    } );
    let num = table.columns().count()
    for (let i = 7; i < num - 1; i++){
        table.column(i).visible(false);
    }

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
            row.child( format(row.data(), table) ).show();
            tr.addClass('shown');
        }
    } );
});

function format ( d, table ) {
    // `d` is the original data object for the row
    let innards = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
    for(let i = 7; i < table.columns().count() - 1; i++){
        innards += '<tr>'+ '<td>'+$(table.column(i).header()).html()+'</td>'+ '<td>'+d[i]+'</td>'+'</tr>';
    }
    innards += '</table>';
    return innards;
}