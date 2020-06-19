console.log('hello');
window.onload = () => {





  function handleResponse(data){
    console.log("got" + info)
  }


  function handleClick(e){
    console.log('clicked');
    var info = "hello world ";
    console.log(info)
    $('.infoo').append(info);
    $.ajax('/', {
      type: 'POST',
      data: {
        text: info
        },
      success: handleResponse


    });
  }



  $(document).ready(function () {
    $(".circle").click(handleClick);

  })
}
/*

$(document).ready(function(){
  $("button").click(function(){
    $("#div1").load("demotext.txt");
  });
});
*/
