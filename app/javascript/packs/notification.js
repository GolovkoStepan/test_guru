function notification(content, opts) {
    opts = $.extend( true, {
        type: 'primary', //primary, secondary, success, danger, warning, info, light, dark
        position: 'topcenter', //topleft, topcenter, topright, bottomleft, bottomcenter, bottonright, center,
        appendType: 'append', //append, prepend
        closeBtn: false,
        autoClose: 5000,
        className: '',
    }, opts);

    let $container = $('#alert-container-'+ opts.position);

    if (!$container.length) {
        $container = $('<div id="alert-container-' + opts.position + '" class="alert-container"></div>');
        $('body').append($container);
    }

    let $el = $(`<div class="alert fade alert-${opts.type} show" role="alert">${content}</div>`);

    if (opts.closeBtn) {
        $el.append(`
					<button type="button" class="close" data-dismiss="alert" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				  `)
           .addClass('alert-dismissible');
    }

    if (opts.autoClose) { setTimeout(() => { $el.alert('close'); }, opts.autoClose); }

    opts.appendType === 'append' ? $container.append($el) : $container.prepend($el);
}

export { notification }
