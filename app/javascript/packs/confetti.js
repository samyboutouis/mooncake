window.onload = function() {
    var canvas = document.getElementById("canvas");
    var ctx = canvas.getContext("2d");
    var W = window.innerWidth;
    var H = window.innerHeight - 200;
   
    
    canvas.width = W;
    canvas.height = H;

    var particles = [];
  
    // Add starting particles
    for (var i = 0; i < 25; i++) {
      addParticle();
    }
    // Add a particle every tenth of a second
    setInterval(addParticle, 10);
    // Update the particles so they fall
    
  
    // Add a single particle
    function addParticle() {
      if (particles.length > 1000) {
        return false;
      }
  
      particles.push({
        x: Math.random() * W, //x-coordinate
        y: Math.random() * H, //y-coordinate
        r: Math.random() * 18 + 1, //radius
        d: Math.random() * particles.length, //density
        color: "rgba(" + Math.floor((Math.random() * 255)) + ", " + Math.floor((Math.random() * 255)) + ", " + Math.floor((Math.random() * 255)) + ", 0.8)",
        tilt: Math.floor(Math.random() * 5) - 5
      });
    }
  
    /* Draw the particles */
    function draw() {
      ctx.clearRect(0, 0, W, H);
      for (var i = 0; i < particles.length; i++) {
        var p = particles[i];
        ctx.beginPath();
        ctx.lineWidth = p.r;
        ctx.fillStyle = p.color;
        ctx.moveTo(p.x, p.y);
        ctx.beginPath();
        ctx.moveTo(p.x, p.y);
        ctx.lineTo(p.x + 10, p.y);
        ctx.lineTo(p.x + 5, p.y + 10);
        ctx.fill();
      }
  
      update();
    }

    var angle = 0.02;
  
    function update() {
      angle += 0.01;
      for (var i = 0; i < particles.length; i++) {
        var p = particles[i];
        p.y += Math.cos(angle + p.d) + 1 + p.r / 2;
        p.x += Math.sin(angle) * 2;
        if (p.x > W + 5 || p.x < -5 || p.y > H) {
          if (i % 3 > 0) //66.67% of the flakes
          {
            particles[i] = {
              x: Math.random() * W,
              y: -10,
              r: p.r,
              d: p.d,
              color: p.color,
              tilt: p.tilt
            };
          }
        }
      }
    }
    setInterval(draw, 20);
  };