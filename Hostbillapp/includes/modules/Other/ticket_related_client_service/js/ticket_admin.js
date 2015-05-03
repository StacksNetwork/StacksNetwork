(function( $ ) {

	/**
	 * Generate opion text
	 * @param 	related
	 * @returns {string}
	 */
	function generate_option_text( related ) {

		// shared hosting - hosting A - domain.com
		var option_text = related.cat_name + ' - ' + related.prod_name;

		if( related.domain  ) {
			option_text += ' - ' + related.domain;
		}

		return option_text;
	}

	// save original bindTicketEvents
	var org_bindTicketEvents = window.bindTicketEvents;

	// proxy for bindTicketEvents in order to bind to that event
	window.bindTicketEvents = function(){

		// call original
		org_bindTicketEvents();

		var $tagsCont = $( document.getElementById('tagsCont') );

		// check if this is ticket view
		if( $tagsCont.length ) {

			var ticket_id 	= $( document.getElementById('ticket_id') ).val();
			var url 		= '?cmd=ticket_related_client_service&action=get_ticket_related_service&ticket_id=' + ticket_id;

			$.getJSON( url, function( response ) {

				var related 	= response.ticket_related_service;

				if( related ) {

					var link_url = '?cmd=accounts&action=edit&id=' + related.acc_id  + '&list=all" id="ticket_related_service';

					$tagsCont.after(
						'<a href="' + link_url + '" target="_blank" style="display: block; margin: 10px 0 10px 0; font-weight:bold;">' +
							'相关服务: ' +
							generate_option_text( related ) +
						'</a>'
					);
				}
			});

		}

	};

})(jQuery); // end IIFE wrapper