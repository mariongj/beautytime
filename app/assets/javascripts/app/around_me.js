$(document).ready(function() {
  $("#around-me").click(function(e){
    e.preventDefault();

    console.log("test");
    getLocation();
  });

  function getLocation() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(updatePosition);
    }
  }

  function updatePosition(position) {
    $("#lat").val(position.coords.latitude);
    $("#lng").val(position.coords.longitude);
    $("#around-me-form").trigger('submit');
  }
});
