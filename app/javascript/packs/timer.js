// function idleLogout() {
//     var t;
//     window.onload = resetTimer;
//     window.onmousemove = resetTimer;
//     window.onmousedown = resetTimer;  // catches touchscreen presses as well      
//     window.ontouchstart = resetTimer; // catches touchscreen swipes as well 
//     window.onclick = resetTimer;      // catches touchpad clicks as well
//     window.onkeypress = resetTimer;   
//     window.addEventListener('scroll', resetTimer, true); // improved; see comments

//     function yourFunction() {
//         // your function for too long inactivity goes here
//         // e.g. window.location.href = 'logout.php';
//         //sessionStorage.clear();
//         //location.replace('https://oauth.oit.duke.edu/oidc/logout.jsp');
//         //return false;
//         //window.location.href = "/logout";
//         //$.ajax('/logout', { type: 'POST', data: { _method: 'DELETE' } });
        
//         $.ajax('/logout', { type: 'DELETE' });
//         //  $.ajax('/logout', {
//         //      type: "DELETE",
//         //      url: oauth.oit.duke.edu/oidc/logout.jsp
//         // });

// }

//     function resetTimer() {
//         clearTimeout(t);
//         t = setTimeout(yourFunction, 10000);  // time is in milliseconds
//     }
// }
// idleLogout();