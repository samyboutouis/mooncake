var col = 0;

$(document).ready(function(){
    $("#frm1").submit();
});

$(document).ready(function () {
    // document.getElementById("selected_action").style.visibility = "hidden";

    var table = $('#myTable').DataTable({"aLengthMenu": [[2, 20, 50, 100, -1], [2, 20, 50, 100, "All"]],
        columnDefs: [
            {
                orderable: false,
                targets: [0]
            }],
        order: [[ 1, 'asc' ]],
        stateSave: true,


        "fnDrawCallback": function(){
          let yes = $(".yes").closest("tr")
          yes.addClass('greens')
          let maybe = $(".maybe").closest("tr")
          maybe.addClass('oranges')
          let no = $(".noo").closest("tr")
          no.addClass('reds')
        }

    } );

    if ($("#myTable").length > 0) {
        let num = table.columns().count();
        let x = -1;
        if ((table.column(8).header().innerText).trim() != "Which prerequisite(s) have you satisfied:") {
            x = 8;
            col = 8;
        }
        else {
            x = 9;
            col = 9;
        }
        for (let i = x; i < num - 1; i++){
            table.column(i).visible(false);
        }

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
    $('#myTable thead').on('click', 'img#hide', function (e) {
        e.preventDefault();
        var table = $('#myTable').DataTable();
        // Get the column API object
        var column = table.column($(this).closest('th'))[0][0];
        // Toggle the visibility
        // column.visible( ! column.visible() );
        table.column(column).visible( false );
    } );

    $('#myTable thead').on('click', 'img#unhide', function () {
        var table = $('#myTable').DataTable();
        for (let i = 1; i < col; i++) {
            table.column(i).visible( true);
        }
    } );

    var allPages = table.cells( ).nodes( );
    $('.selectall').on('click', function(e) {
        if ($(this).hasClass('checkboxlist')) {
            $('input[type="checkbox"]', allPages).prop('checked', false);
        } else {
            $('input[type="checkbox"]', allPages).prop('checked', true);
        }
        $(this).toggleClass('checkboxlist');

        var ischecked =$('input[type=checkbox]:checked', allPages).length;
        if(ischecked > 0) {
            document.getElementById("selected_action").style.visibility = "visible";
        } else {
            document.getElementById("selected_action").style.visibility = "hidden";
        }

    });

    $('.checkboxlist').on('change', function(){
        $('.selectall').trigger('change');
    });

    $('.checkboxlist').on('change', function(){
        // console.log(document.getElementById("selected_action"))

        var ischecked =$('input[type=checkbox]:checked', allPages).length;
        if(ischecked > 0) {
            document.getElementById("selected_action").style.visibility = "visible";
        } else {
            document.getElementById("selected_action").style.visibility = "hidden";
        }

    });

    $('#myTable').on( 'draw.dt', function () {

        $('.selectall').on('click', function(e) {
          if ($(this).hasClass('checkboxlist')) {
              $('input[type="checkbox"]', allPages).prop('checked', false);
          } else {
              $('input[type="checkbox"]', allPages).prop('checked', true);
          }
          $(this).toggleClass('checkboxlist');

          var ischecked =$('input[type=checkbox]:checked').length;
          if(ischecked > 0) {
              document.getElementById("selected_action").style.visibility = "visible";
          } else {
              document.getElementById("selected_action").style.visibility = "hidden";
          }

        });

        $('.checkboxlist').on('change', function(){
            $('.selectall').trigger('change');
        });

        $('.checkboxlist').on('change', function(){
            // console.log(document.getElementById("selected_action"))

            var ischecked =$('input[type=checkbox]:checked', allPages).length;
            if(ischecked > 0) {
                document.getElementById("selected_action").style.visibility = "visible";
            } else {
                document.getElementById("selected_action").style.visibility = "hidden";
            }

        });
    } );




});

// function SelectAction() {
//     var act = document.getElementById("selected_action").value;
//     console.log(act)
//     document.getElementById(act).click();
// }


function format ( d, table ) {
    // `d` is the original data object for the row
    let innards = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
    let x = -1;
    if ((table.column(8).header().innerText).trim() != "Which prerequisite(s) have you satisfied:") {
        x = 8;
    }
    else {
        x = 9;
    }
    for(let i = x; i < table.columns().count() - 1; i++){
        innards += '<tr>'+ '<td>'+$(table.column(i).header()).html()+'</td>'+ '<td>'+d[i]+'</td>'+'</tr>';
    }
    innards += '</table>';
    return innards;
}
