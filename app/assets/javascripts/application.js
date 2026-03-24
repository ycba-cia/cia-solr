// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require_tree .
function getartistsdata() {
    console.log("in getartistsdata");
    var nametype = document.getElementsByName("nametype")[0].value;
    var name = document.getElementsByName("name")[0].value;
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            //todostart here mon jun30
            var body = document.getElementById('artistsresults');
            body.innerHTML = "";
            var obj = JSON.parse(this.responseText);
            //var images = obj["images"];
            var artists = obj;
            console.log("artists:"+ artists);
            for (i = 0; i < artists.length; i++) {
                body.innerHTML += "<tr>" +
                    "<td>" + artists[i]["ConstituentID"] + "</td>" +
                    "<td>" + artists[i]["DisplayName"] + "</td>" +
                    "<td>" + artists[i]["DisplayDate"] + "</td>"
            }
            /*
                if (images[i]["del"] === undefined || images[i]["del"] == "0") {
                    body.innerHTML += "<tr>" +
                        "<td><input type='checkbox' class='imageselect' id='" + images[i]["fn"] + "' name='images[]' value='" + images[i]["fn"] + "|" + images[i]["path"] + "'></td>" +
                        "<td>" + images[i]["fn"] + "</td>" +
                        "<td>" + images[i]["del"] + "</td>" +
                        "<td>" + images[i]["delreq"] + "</td>" +
                        "<td>" + images[i]["rend"] + "</td>" +
                        "<td>" + images[i]["path"] + "</td>"
                } else {
                    body.innerHTML += "<tr>" +
                        "<td><input disabled type='checkbox' class='imageselect' id='" + images[i]["fn"] + "' name='images[]' value='" + images[i]["fn"] + "|" + images[i]["path"] + "'></td>" +
                        "<td>" + images[i]["fn"] + "</td>" +
                        "<td>" + images[i]["del"] + "</td>" +
                        "<td>" + images[i]["delreq"] + "</td>" +
                        "<td>" + images[i]["rend"] + "</td>" +
                        "<td>" + images[i]["path"] + "</td>"
                }
            }
            document.getElementById('output').style = "display: block;";*/
        }
    }
    xhttp.open("GET", "/artistimage/getconstituentdata?nametype="+nametype+"&name="+name, true);
    xhttp.send();
}