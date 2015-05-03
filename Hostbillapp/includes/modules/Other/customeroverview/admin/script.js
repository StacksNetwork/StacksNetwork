$(function() {
    var CLIENTS = {};
    var TPL = "<div>加载中..</div>";
    var tipsy = 1;
    if ($.fn.tipsy == undefined) {
        tipsy = 0;
        $.getScript('templates/default/js/jquery.tipsy.js', function() {
            tipsy = 1;
        });
    }


    function handleClient(response, client) {
        var self = $(this);
        client.load = 2;
        client.data = parse_response(response);
        if (self.data('tipsy').hoverState == 'in') {
            self.data('tipsy').state = 'hidden';
            self.trigger('mouseenter.tipsy');
        }
    }
    function showClient(client) {
        CLIENTS[client.id] = client;
        var self = $(this);

        self.tipsy({
            html: true,
            fade: 1,
            gravity: function(){
                if(self.offset().left > $(document).width()/2)
                    return 'e';
                return 'w';
            },
            trigger: 'manual',
            opacity: 1,
            title: function() {
                return client.data;
            }
        });

        var tipsy = self.data('tipsy');
        tipsy.state = 'hidden';
        tipsy.tip().attr('id', 'client-overview');
        //console.log('hidden');
        function enter(e) {
            tipsy.hoverState = 'in';
            tipsy.fixTitle();
            // console.log('in');
            setTimeout(function() {
                if (tipsy.hoverState == 'in' && tipsy.state != 'visibe') {
                    //console.log('show');
                    tipsy.state = 'visibe';
                    tipsy.show();
                    tipsy.tip().bind('mouseenter.tipsy', enter).bind('mouseleave.tipsy', leave);
                }
            }, 600);

        }

        function leave(e) {
            tipsy.hoverState = 'out';
            //console.log('out');
            setTimeout(function() {
                if (tipsy.hoverState == 'out') {
                    //console.log('hide');
                    tipsy.hide();
                    tipsy.state = 'hidden';
                }
            }, 300);

        }

        self.bind('mouseenter.tipsy', enter).bind('mouseleave.tipsy', leave);
        enter();
        //console.log(tips, client)
    }

    $(document).on('mouseenter mouseleave', '#content_tb a[href*="?cmd=clients&action=show&id="]:not(.nav, .nav_el)', function(e) {
        var self = $(this),
            cid = self.attr('href').match(/id=(\d+)/)[1];
        if (!cid || !cid.length)
            return false;

        var client = CLIENTS[cid] || {id: cid, data: TPL},
        data = self.data('_overview') || {};

        if (!self.data('tipsy')) {
            showClient.call(self, client);
        }
        if(client.timeout)
            clearTimeout(client.timeout);

        if (e.type == 'mouseenter') {
            if (!client.load) {
                client.timeout = setTimeout(function() {
                    client.load = 1;
                    $.get('?cmd=customeroverview&id=' + cid, function(response) {
                        handleClient.call(self, response, client);
                    });
                }, 150);
            }
        }
        self.data('_overview', data);
        CLIENTS[cid] = client;
    })
})
