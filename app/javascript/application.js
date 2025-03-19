// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

//= require jquery3
//= require jquery_ujs
//= require bootstrap-sprockets

import "@hotwired/turbo-rails"
import "controllers"


document.addEventListener("turbo:load", function() {
  const suns = document.querySelectorAll('.header-sun');

  document.querySelector('.logo-mycraft').addEventListener('mouseenter', function() {
      suns.forEach(function(sun) {
          sun.style.top = '60px';
          sun.style.left = '500px';
      });
  });

  document.querySelector('.logo-mycraft').addEventListener('mouseleave', function() {
      suns.forEach(function(sun) {
          sun.style.top = '80px';
          sun.style.left = '120px';
      });
  });
});

document.addEventListener("turbo:load", function() {
  const checkbox = document.getElementById("menu-toggle");

  function toggleCheckbox() {
      if (window.innerWidth > 991) {
          checkbox.disabled = true;
          checkbox.checked = false;
      } else {
          checkbox.disabled = false;
      }
  }

  toggleCheckbox();
  window.addEventListener("resize", toggleCheckbox);
});