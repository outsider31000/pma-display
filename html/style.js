$(document).ready(function(){
    $("body").hide();

    window.addEventListener('message', function(event) {
        var data = event.data;

        if (data.show === false) {
            $("body").hide();
            return;
        }

        $("body").show();

        if (data.muted) {
            $('.mic1').removeClass('muted');
            $('.mic2').addClass('hide');
            $('.mic1').removeClass('hide');
        } else if (!data.talking) {
            $('.mic1').addClass('hide');
            $('.mic2').removeClass('hide');
        } else {
            $('.mic1').addClass('muted');
            $('.mic2').addClass('hide');
            $('.mic1').removeClass('hide');
        }

        var mode = data.mode;
        var wave = document.querySelectorAll('.wave3')[0];
        if (!wave) return;

        if (mode === 1) {
            wave.style.setProperty("--top", "30%");
        } else if (mode === 2) {
            wave.style.setProperty("--top", "0%");
        } else if (mode === 3) {
            wave.style.setProperty("--top", "-25%");
        } else {
            wave.style.setProperty("--top", "-50%");
        }
    });
});
