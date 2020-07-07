var count = 0;
$(document).ready(function () {

  $("#add-prereq").on('click', function() {
    createField();
  });
  $(".custom-file-input").on("change", function() {
    var fileName = $(this).val().split("\\").pop();
    $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
  });
  
});



function createField() {
    count++;
    var clonedField = $(".prereqfield:first").clone();
    clonedField.attr("name", "prereq_attributes["+ count + "]name" );
    clonedField.appendTo(".addNew");
}
