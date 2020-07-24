$(document).on('turbolinks:load', function() {
    $('#password').add('#password-confirm').keyup(function () {
        let password = $('#password').val()
        let pass_confirm = $('#password-confirm').val()

        if (password !== '' && pass_confirm !== '') {
            if (password === pass_confirm) {
                $('#pass-icon-success').show()
                $('#pass-icon-danger').hide()
            } else {
                $('#pass-icon-success').hide()
                $('#pass-icon-danger').show()
            }
        } else {
            $('#pass-icon-success').hide()
            $('#pass-icon-danger').hide()
        }
    });
})
