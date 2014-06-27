$(document).ready(function() {
    $('.js-popup').click(function() {
        centerPopup($(this).attr('href'), $(this).attr('data-width'), $(this).attr('data-height'));
        return false;
    });
});

function centerPopup(linkUrl, width, height) {
    var sep = (linkUrl.indexOf('?') !== -1) ? '&' : '?',
        url = linkUrl + sep + 'popup=true',
        left = (screen.width - width) / 2 - 16,
        top = (screen.height - height) / 2 - 50,
        windowFeatures = 'menubar=no,toolbar=no,status=no,width=' + width +
            ',height=' + height + ',left=' + left + ',top=' + top;
    return window.open(url, 'authPopup', windowFeatures);
}
