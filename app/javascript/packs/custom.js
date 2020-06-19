console.log('hello');

function handleClick(e){
  console.log('clicked');
  var info = "hello world"; //find a way to load info
  console.log(info)
  $.ajax('/', {
    type: 'POST',
    data: info
    
  }); //perform asyn action
}



$(document).ready(function () {
  $(".circle").click(handleClick);

})

/*

$(document).ready(function(){
  $("button").click(function(){
    $("#div1").load("demotext.txt");
  });
});
*/
