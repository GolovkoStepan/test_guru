$(document).on('turbolinks:load', function() {
    let $timer = $('#timer')
    let $form  = $('#test-form')
    let seconds = parseInt($timer.data('time'));

    if (seconds) {
        if (seconds <= 0) { $form.submit() }
        $timer.text(convertTime(seconds, ':'))
        seconds -= 1

        setInterval(function() {
            if (seconds > 0) {
                $timer.text(convertTime(seconds, ':'))
                seconds -= 1
            } else {
                $form.submit()
            }
        }, 1000)
    }
});

function convertTime(input, separator) {
    const pad = function (input) { return input < 10 ? "0" + input : input; };
    return [
        pad(Math.floor(input / 3600)),
        pad(Math.floor(input % 3600 / 60)),
        pad(Math.floor(input % 60)),
    ].join(typeof separator !== 'undefined' ? separator : ':');
}
