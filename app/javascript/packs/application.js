import "bootstrap";
import "particles.js";

if (document.getElementById('login-form')) {
  particlesJS.load('login-form', '../assets/stylesheets/particles.json', function() {
    console.log('callback - particles.js config loaded');
  });
}
