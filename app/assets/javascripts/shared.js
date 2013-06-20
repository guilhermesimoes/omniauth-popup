$(document).ready(function() {
    if ($('#js-messages').children().length) {
        setTimeout(hideFlashMessages, 3000);
    }
});

function hideFlashMessages() {
    $('#js-messages').animate({ opacity: 'toggle', width: 'toggle' }, 3000, function() {
        $(this).empty();
    });
}
