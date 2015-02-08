// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function colorTds() {
  $('td').each(function( index, value ) {
    colorTd(value);
  });
}

function colorTd(td) {
  var v = td.innerText
  if(v=='false')
    $(td).css('background-color', 'orangered');  
  if(v=='true')
    $(td).css('background-color', 'limegreen');
  
  if(v=='COOL')
    $(td).css('background-color', 'aqua');
  if(v=='CRITICAL')
    $(td).css('background-color', 'orange');
  if(v=='OVERDUE')
    $(td).css('background-color', 'orangered');
  if(v=='DONE')
    $(td).css('background-color', 'limegreen');
  if(v=='NEVER DONE')
    $(td).css('background-color', 'orangered');
  if(v=='UNKNOWN')
    $(td).css('background-color', 'pink');
}
