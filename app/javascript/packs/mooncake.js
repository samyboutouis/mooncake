window.onload = () => {
    let circle = document.getElementById("circle");
    circle.addEventListener("click", function() {
        let requestBox = circle.parentElement;
        requestBox.style.background = "purple";
    });
}

// $(document).ready(function(){
//     $(".circle").click(function(){
        
//       });
// });

// window.onload = () => {
//       var dataCount = 1;
//       var animalContainer = document.getElementById("moon");
//       var cor = document.getElementsByClassName("eachcourse");
//       var i = cor.length;
    
    
//       while (i--)
//         cor[i].addEventListener("click", function() {
//           var ourRequest = new XMLHttpRequest(); //this starts everything
    
//           ourRequest.open('GET', 'https://learnwebcode.github.io/json-example/animals-' + dataCount +'.json'); //bc we want to get data, not post, find how to replace link with database call
//           ourRequest.onload = function() {
//             var ourData = JSON.parse(ourRequest.responseText);
//             renderHTML(ourData);
//           };
//           ourRequest.send();
//           dataCount++;
//         });
//       ;
    
//       function renderHTML(data){
//         var htmlString = "this is a test"
    
//         for (h = 0; i < data.length; i ++) {
//           htmlString += "<p>" + data[i].name + " is a "
//         }
    
//         animalContainer.insertAdjacentHTML('beforeend', htmlString);
    
//       }
    
    
//       console.log('Hello from application.js')
//     }