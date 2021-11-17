'use strict';
/**
 * Component: Overlay
 */

var umbraco = umbraco || {};

umbraco.overlay = umbraco.overlay || function() {
    var self = this;
    /**
     * Backdrop function, adds the shadowy layer to the background
     */
    function backdrop() {
        if ($('#overlay-backdrop').length !== 1) {
            $('body').append('<div id="overlay-backdrop" class="overlay-backdrop"></div>');
            $('#overlay-backdrop').height($('body').height());

            $('#overlay-backdrop').on('click', function(){
                destroy();
            });

            // escape click bind on close button
            $(document).keyup(function (e) {
                if (e.keyCode == 27) {
                    destroy();
                }
            });
        }
    }

    /**
     * Creates the overlay on top of the backdrop
     */
    function create(data) {
        // reset overlay the hard way
        if ($('#overlay').length === 1) {
            $('#overlay, #overlay-content').remove();
        }
        else {
            backdrop();
        }

        var btnClose = $('<a><svg class="overlay-close__icon"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="/assets/images/icons.svg#cross"></use></svg></a>').attr({'href': '#', 'class': 'overlay-close', 'id': 'closeOverlay'});

        var overlayInner = $('<div>').addClass('overlay-inner').append($('<div>').addClass('overlay-inner-scroll').append(data.content));

        $('body').append($('<div>').attr('id', 'overlay-content').append(btnClose).append(overlayInner).fadeIn("fast"));

        setTimeout(function(){
            $('#overlay-content').addClass('active');
        }, 100);

        if (data['class'] !== undefined) {
            $('#overlay-content').addClass(data['class']);
        }

        $('#closeOverlay').on("click", function (e) {
            e.preventDefault();
            destroy();
        });
    }

    /**
     * Destroy the overlay and the backdrop, also closes all .js-open components
     */
    function destroy() {
        if ($('#overlay-backdrop').length === 1) {
            // Remove all js-active elements
            $('.open').removeClass('open');

            $('#overlay-backdrop, #overlay-content').remove();
            
        }
    }
    return {
        backdrop: backdrop,
        create: create,
        destroy: destroy
    };
}();