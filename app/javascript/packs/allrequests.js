$(document).ready( function () {
    $('#allrequestsTable').DataTable({"aLengthMenu": [[10, 20, 50, 100, -1], [10, 20, 50, 100, "All"]]});

    $("#email-all").on('click', function() {
        $("#hidden-email-all").click();
      });
      
});
