var count = 0;
$(document).ready(function () {

  $("#add-prereq").on('click', function() {
    createField();
  });
});



function createField() {
    count++;
    var clonedField = $(".prereqfield:first").clone();
    clonedField.attr("name", "prereq_attributes["+ count + "]name" );
    clonedField.appendTo(".addNew");
}
