(function ($) {
	// Define the scrolly namespace and default settings
	$.scrolly = {
		defaults: {
			page: 1,
			pageKey: 'page',
			dataUrl: '',
            template: '',
			loadingHtml: '<small>Loading...</small>',
			callback: false
		}
	};

	// Constructor
	var scrolly = function ($e, options) {

		// Private vars
		var _data = $e.data('scrolly'),
            _userOptions = (typeof options === 'function') ? { callback: options } : options,
            _options = $.extend({}, $.scrolly.defaults, _userOptions, _data || {}),
            _isWindow = ($e.css('overflow-y') === 'visible'),
            _$window = $(window),
            _$body = $('body'),
            _$scroll = _isWindow ? _$window : $e

		// Initialization
		$e.data('scrolly', $.extend({}, _data, { initialized: true, waiting: false }));
		_setBindings();


		// Observe the scroll event for when to trigger the next load
		function _observe() {
			
			var $inner = $e.find('tr').last(),
                data = $e.data('scrolly'),
                borderTopWidth = parseInt($e.css('borderTopWidth')),
                borderTopWidthInt = isNaN(borderTopWidth) ? 0 : borderTopWidth,
                iContainerTop = parseInt($e.css('paddingTop')) + borderTopWidthInt,
                iTopHeight = _isWindow ? _$scroll.scrollTop() : $e.offset().top,
                innerTop = $inner.length ? $inner.offset().top : 0,
                iTotalHeight = Math.ceil(iTopHeight - innerTop + _$scroll.height() + iContainerTop);

			if (!data.done && !data.waiting && iTotalHeight >= $inner.outerHeight()) {			
				_load();
			}
		}

		function _setBindings() {
			
			if (_$body.height() <= _$window.height()) {
				_observe();
			}
			_$scroll.unbind('.scrolly').bind('scroll.scrolly', function () {
				return _observe();
			});
			
			
		}


		function _load() {

			var $inner = $e.find('tbody').last(),
                data = $e.data('scrolly');

			data.waiting = true;
			$('<div class="scrolly-loading">' + _options.loadingHtml + '</div>').insertAfter($inner);

			return $e.animate({ scrollTop: $inner.outerHeight() }, 0, function () {
				
				_options.page++;

				$.ajax({
					url: _options.dataUrl + '&'+ _options.pageKey +'=' + _options.page,
					type: 'GET',
				})
				.done(function (dat) {

				    if (dat.length == 0) { data.done = true };

					var template = $(_options.template).html();
					var rendered = Mustache.render(template, dat);
					$inner.append(rendered);

					data.waiting = false;

					$e.find('.scrolly-loading').remove();
					
					if (!data.done) {
                        //set browser address bar to reflect page
					    try {
					        history.replaceState(null, null, '?' + _options.pageKey + '=' + _options.page);
					    } catch (err) { /*fail silently*/ }
					}

					if (_options.callback) {
						_options.callback.call(this);
					}
				});
				
				
			});
		}
		return $e;

	};

	// Define the scrolly plugin method and loop
	$.fn.scrolly = function (m) {
		return this.each(function () {
			var $this = $(this),
                data = $this.data('scrolly');
			// Instantiate scrolly on this element if it hasn't been already
			if (data && data.initialized) return;
			var scrol = new scrolly($this, m);
		});
	};
})(jQuery);