$(document).on('turbolinks:load', function() {
    $('#search').keyup(function () {
        $('.card').show();
        $('#test_cards')
            .find('.card .card-body .card-title:not(:contains("'+$(this).val()+'"))')
            .parent().parent().hide();
    }).on('search', function () {
        $('.card').show();
    });

    $('#btnSort').click(function () {
        let btn = $('#btnSort')

        if (btn.hasClass('sort_asc')) {
            btn.removeClass('sort_asc')
            btn.addClass('sort_desc')
            btn.html('<i class="fas fa-sort-alpha-down"></i>')
            $('.card').sort(sort_desc).appendTo("#test_cards");
        } else if (btn.hasClass('sort_desc')) {
            btn.removeClass('sort_desc')
            btn.addClass('sort_asc')
            btn.html('<i class="fas fa-sort-alpha-up"></i>')
            $('.card').sort(sort_asc).appendTo("#test_cards");
        } else {
            btn.addClass('sort_desc')
            btn.html('<i class="fas fa-sort-alpha-down"></i>')
            $('.card').sort(sort_desc).appendTo("#test_cards");
        }
    });
})

function sort_asc(a, b) {
    let text_a = $(a).find(".card-title").text()
    let text_b = $(b).find(".card-title").text()

    if (text_a < text_b) { return 1; }
    if (text_a > text_b) { return -1; }

    return 0
}

function sort_desc(a, b) {
    let text_a = $(a).find(".card-title").text()
    let text_b = $(b).find(".card-title").text()

    if (text_a > text_b) { return 1; }
    if (text_a < text_b) { return -1; }

    return 0
}
