//var apiUrl = "http://student.howest.be/jasper.van.damme/20142015/MA4/BADGET/api"
var apiUrl = "../api"

function init() {
    $.get(apiUrl + "/users", function(data) {
        $.each(data, function() {
            $('#users ul').append(data);
        });
    });
}

init();