$(document).ready(function () {
    var table = $('#myTable').DataTable( {
        columnDefs: [ 
            { 
                orderable: false, 
                targets: [0] 
            }],
        order: [[ 1, 'asc' ]],
    } );
    let num = table.columns().count();
    let x = -1;
    if (table.column(6).header().innerText != "Which course(s) have you taken:") {
        x = 6;
    }
    else {
        x = 7;
    }
    for (let i = x; i < num - 1; i++){
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
    let x = -1;
    if (table.column(6).header().innerText != "Which courses have you taken:") {
        x = 6;
    }
    else {
        x = 7;
    }
    for(let i = x; i < table.columns().count() - 1; i++){
        innards += '<tr>'+ '<td>'+$(table.column(i).header()).html()+'</td>'+ '<td>'+d[i]+'</td>'+'</tr>';
    }
    innards += '</table>';
    return innards;
}