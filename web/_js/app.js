function init() {
    $.get("../api/users", function(data) {
        $.each(data, function() {
            $.each(this, function(k, v) {
                console.log(k, v);
            });
        });
    });
}

init();