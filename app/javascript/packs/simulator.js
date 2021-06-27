function updateInputBox(value) {
  $('#inputBox')[0].innerHTML =  $('#inputBox')[0].innerHTML + value + "<br/>";
}

function simulate(values) {
  $.ajax({
    type: "POST",
    headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') },
    contentType: "application/json; charset=utf-8",
    url: "/simulator/simulate",
    data : JSON.stringify({commands: JSON.stringify(values)}),
    dataType: "json",
    success: function (response) {
      let text = response.results.map(function(result) {
        return "Output: " + result
      }).join("<br>")

      document.getElementById('outputBox').innerHTML = text
      document.getElementById('inputBox').innerHTML = ""
    },
    error: function (){
      window.alert("something wrong!");
    }
  });
}

$(".action-button").on("click", function(event){
  updateInputBox(event.target.innerText)
});

$("#place").on("click", function(){
  if ( $('#x')[0].value && $('#y')[0].value && $('#direction')[0].value)
    updateInputBox(`PLACE(${$('#x')[0].value}, ${$('#y')[0].value}, ${$('#direction')[0].value})`)
});

$("#execute").on("click", function(){
  let values = $('#inputBox')[0].innerHTML.split("<br>").filter(function(el) { return el !== ""; })

  if ( values.length > 0 )
    simulate(values);
});
