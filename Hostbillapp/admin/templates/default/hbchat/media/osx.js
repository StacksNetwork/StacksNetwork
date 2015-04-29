/*
 * SimpleModal OSX Style Modal Dialog
 * http://www.ericmmartin.com/projects/simplemodal/
 * http://code.google.com/p/simplemodal/
 *
 * Copyright (c) 2010 Eric Martin - http://ericmmartin.com
 * Modified Kris Pajak, HostBill team
 *
 * Licensed under the MIT license:
 *   http://www.opensource.org/licenses/mit-license.php
 *
 * Revision: $Id: osx.js 238 2010-03-11 05:56:57Z emartin24 $
 */

var OSX = {
    container: null,
		
    open: function (d) {
        var self = this;
        self.container = d.container[0];
        d.overlay.fadeIn('fast', function () {
            $("#osx-modal-content", self.container).show();
            var title = $("#osx-modal-title", self.container);
            title.show();
            d.container.slideDown('fast', function () {
                setTimeout(function () {
                    var h = $("#osx-modal-data", self.container).height()
                    + title.height()
                    + 20; // padding
                    d.container.height(h);
                        $("div.close", self.container).show();
                        $("#osx-modal-data", self.container).show();
                   
                }, 100);
            });
        })
    },
    close: function (d) {
        var self = this; // this = SimpleModal object
        d.container.animate(
        {
            top:"-" + (d.container.height() + 20)
            },
        500,
        function () {
            self.close(); // or $.modal.close();
        }
        );
    }
};



function open_modal(title,content) {
   
}