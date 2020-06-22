console.log('hello');

$(document).ready(function () {
  $(".course").on('click', function() {
    console.log('clicked');
  
    let course = $(this).text();
    let department = course.split(" ")[0];
    let number = course.split(" ")[1];
    console.log(`${department} + ${number}`);
    $.ajax('/request', {
      type: 'GET',
      dataType: 'json',
      data: {
        department: department, number: number
      },
      success: handleResponse
    });
  });
})


function handleResponse(data){
  
}
/*

$(document).ready(function(){
  $("button").click(function(){
    $("#div1").load("demotext.txt");
  });
});
*/
