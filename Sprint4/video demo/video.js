var keywords = ["SELECT","FROM","WHERE","LIKE","BETWEEN","NOT LIKE","FALSE","NULL","FROM","TRUE","NOT IN"];
var keywords2 = ["main"];
var keywords3 = ["#include"];
var keywords4 = ["cout", "sin", "endl"];
var keywords5 = ["using","namespace", "int", "double", "return"];
var keywords6 = ["0", "1.4", "2", "2.3"];
var keywords7 = ["hello", "there"];
var keywords8 = ["//comments"];

$("#editor").on("keyup", function(e){
 
  if (e.keyCode == 32){
    var newHTML = "";
 
    $(this).text().replace(/[\s]+/g, " ").trim().split(" ").forEach(function(val){
      // If word is statement
      if (keywords.indexOf(val.trim().toUpperCase()) > -1)
        newHTML += "<span class='statement'>" + val + "&nbsp;</span>";
      else if (keywords2.indexOf(val.trim().toLowerCase()) > -1)
        newHTML += "<span class='function'>" + val + "&nbsp;</span>";
      else if (keywords3.indexOf(val.trim().toLowerCase()) > -1)
        newHTML += "<span class='directives'>" + val + "&nbsp;</span>";
      else if (keywords4.indexOf(val.trim().toLowerCase()) > -1)
        newHTML += "<span class='lib'>" + val + "&nbsp;</span>";
      else if (keywords5.indexOf(val.trim().toLowerCase()) > -1)
        newHTML += "<span class='ident'>" + val + "&nbsp;</span>";
      else if (keywords6.indexOf(val.trim().toLowerCase()) > -1)
        newHTML += "<span class='numb'>" + val + "&nbsp;</span>";
      else if (keywords7.indexOf(val.trim().toLowerCase()) > -1)
        newHTML += "<span class='strings'>" + val + "&nbsp;</span>";
      else if (keywords8.indexOf(val.trim().toLowerCase()) > -1)
        newHTML += "<span class='comments'>" + val + "&nbsp;</span>";
      else
        newHTML += "<span class='other'>" + val + "&nbsp;</span>"; 
    });
    $(this).html(newHTML);

    var child = $(this).children();
    var range = document.createRange();
    var sel = window.getSelection();
    range.setStart(child[child.length-1], 1);
    range.collapse(true);
    sel.removeAllRanges();
    sel.addRange(range);
    this.focus();
  }
});
