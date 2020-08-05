$(document).on('turbolinks:load', function() { $('.form-inline-link').on('click', formInlineLinkHandler) });

function formInlineLinkHandler(event) {
    event.preventDefault()
    formInlineHandler(this.dataset.testId)
}

function formInlineHandler(testId) {
    let link  = $('.form-inline-link[data-test-id="' + testId + '"]')
    let form  = $('.inline-form[data-test-id="' + testId + '"]')
    let title = $('.card-title[data-test-id="' + testId + '"]')

    form.toggle()
    title.toggle()

    form.is(':visible') ? link.html('Назад') : link.html('Изменить')
}
