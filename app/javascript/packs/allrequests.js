$(document).ready( function () {

    $('#allrequestsTable').DataTable({

        "aLengthMenu": [[10, 20, 50, 100, -1], [10, 20, 50, 100, "All"]],
        columnDefs: [
            {
                orderable: false,
                targets: [0]
            }],
            order: [[ 1, 'asc' ]],
            stateSave: true,
  });

    $("#email-all").on('click', function() {
        $("#hidden-email-all").click();
    });



    $('.selectall').on('change', function(e) {
        var $inputs = $('.checkboxlist');
        if(e.originalEvent === undefined) {
            var allChecked = true;
            $inputs.each(function(){
                allChecked = allChecked && this.checked;
            });
            this.checked = allChecked;
        } else {
            $inputs.prop('checked', this.checked);
        }
    });

    $('.checkboxlist').on('change', function(){
        $('.selectall').trigger('change');
    });

});
