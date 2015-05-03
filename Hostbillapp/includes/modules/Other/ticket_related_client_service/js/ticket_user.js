var Add_related_service = {

	/**
	 * Default selection
	 */
	defaultSelection : false,

	/**
	 * Set default selection to new value
	 *
	 * @param default_value
	 */
	setDefaultSelection : function( default_value) {
		this.defaultSelection = default_value;
	},

	/**
	 * Execute adding related service selection
	 */
	execute : function() {

		var defaultSelection = this.defaultSelection;

		/**
		* Add option
		*
		* @param option_text
		* @param value
		* @param $related_client_service
		*/
		function add_option( option_text, value, $related_client_service ) {
			var option = new Option( option_text, value );
			$( option ).html( option_text );
			$related_client_service.append( option );
		}

		/**
		 * Generate option text
		 *
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


		var $ticket_message = $( document.getElementById('ticketmessage') );

		$ticket_message.after(
			'<div>' +
				_trcslang.relatedservice + ': ' +
				'<select id="related_client_service" name="related_client_service">' +
				'</select>' +
				'</div>'
		);

		var $related_client_service = $( document.getElementById('related_client_service') );

		add_option( _trcslang.none, 0, $related_client_service );

		$.getJSON('?cmd=ticket_related_client_service&action=get_related_client_services', function( response ) {

			var related_client_services = response.related_client_services;
			var len 					= related_client_services.length;

			for( var i = 0; i < len; ++i ) {

				var related 	= related_client_services[ i ];
				var option_text = generate_option_text( related_client_services[ i ] );

				add_option( option_text, related.acc_id, $related_client_service );
			}

			if( defaultSelection ) {
				$('#related_client_service').val( defaultSelection );
			}
		});
	}
}
