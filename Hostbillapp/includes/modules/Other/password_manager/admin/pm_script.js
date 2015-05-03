var pm = {
    authorized: false,
    ping: function() {
        $.get('?cmd=password_manager&action=auth', function(r) {
            if (r && r.auth) {
                pm.authorized = true;
            } else {
                pm.authorized = false;
            }
            setTimeout(pm.ping, 30000);
        })
    },
    setauth: function(callback) {
        $.post('?cmd=password_manager&action=auth', {password: $('#facebox input[name=password]').val()}, function(r) {
            $(document).trigger('close.facebox');
            if (r && r.auth) {
                pm.authorized = true;
            } else {
                pm.authorized = false;
            }
            if (typeof callback == 'function')
                callback();
        })
    },
    getauth: function(callback) {
        if (pm.authorized)
            return true;

        $.facebox({div: '#authorize', width: 400, opacity: 0.8, nofooter: true, addclass: 'modernfacebox'});
        $('#facebox #authorize form').submit(function() {
            pm.setauth(callback);
            return false;
        })

        return false;
    },
    showpass: function(id) {
        if (pm.authorized) {
            var ajax = pm.addLoader($('#view' + id));
            $('#view' + id).hide();
            $.post('?cmd=password_manager&action=view', {id: id}, function(r) {
                ajax.remove();
                if (r && r.password) {
                    $('#pass' + id).text(r.password)
                }else if(r && typeof r.auth != 'undefined'){
                    pm.authorized = r.auth;
                    $('#view' + id).show();
                }
            })
        } else {
            pm.getauth(function() {
                if (pm.authorized) {
                    var ajax = pm.addLoader($('#view' + id));
                    $('#view' + id).hide();
                    $.post('?cmd=password_manager&action=view', {id: id}, function(r) {
                        ajax.remove();
                        if (r && r.password) {
                            $('#pass' + id).text(r.password)
                        }else if(r && typeof r.auth != 'undefined'){
                            pm.authorized = r.auth;
                            $('#view' + id).show();
                        }
                    })
                }

            })
        }
    },
    addLoader: function(el) {
        return $('<div class="ajax"></div>').appendTo('body').css($(el).offset());
    },
    generate: function() {
        pm.addLoader($('.my-toggle-class'));
        $('.my-toggle-class').hide();
        $.post('?cmd=security&action=password', {make:'pass_test', numbers:1, lalpha:1, ualpha:1, length:12}, function(data){
            $('.my-toggle-class').show();
            $('.ajax').remove();
            data = parse_response(data);
            if(data && data.length){
                $('#password').val(data).data('loaded', true);
                $('#password').showPassword();
            }
        });
    }
}

$(function() {
    if ($.fn.hideShowPassword)
        $('#password').hideShowPassword({
            show: false,
            innerToggle: true,
            toggleClass: 'my-toggle-class',
        }).on('passwordShown', function() {
            if ($('#entryid').length && !$('#password').data('loaded')) {
                pm.addLoader($('.my-toggle-class'));
                $('.my-toggle-class').hide();
                $.post('?cmd=password_manager&action=view', {id: $('#entryid').val()}, function(r) {
                    $('.my-toggle-class').show();
                    $('.ajax').remove();
                    if (r && r.password) {
                        $('#password').val(r.password).data('loaded', true)
                    }
                })
            }
        });
    pm.ping();
});