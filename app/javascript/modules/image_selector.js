document.addEventListener("DOMContentLoaded", function() {
  const images = document.querySelectorAll(".selectable-image");

  images.forEach(function(image) {
    image.addEventListener("click", function(e) {
      const selected = document.querySelector(".selected-image");
      if (selected) {
        selected.classList.remove("selected-image");
      }
      e.currentTarget.classList.add("selected-image");
    });
  });
});