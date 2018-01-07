(function () {
    require(['masonry'], function (Masonry) {
        function doMasonry() {
            var elem = document.querySelector('#recent_posts');
            var masonry = new Masonry(elem, {
              // options
              itemSelector: '.card__container',
              columnWidth: '.card__container'
            });
            return masonry;
        }
        doMasonry();
        $(window).on('action:ajaxify.contentLoaded', function() {
            var pathname = location.pathname;
            if (pathname === '/') {
                var masonry = doMasonry();
                masonry.layout();
            }
        });
    });
})();
