// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('ready page:load', function () {
  $("#filter").click(function () {
    var year = $("#year").val();
    var month = $("#month").val();
    var url = "/games?year=" + year;
    if (month !== "-") {
      url += "&month=" + month;
    }
    $(this).attr("href", url);
    return true;
  });
})