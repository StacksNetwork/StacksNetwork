$(document).on('click', '#tagsBox span, .inlineTags span', function() {
    var tagstr = $('input[name="filter[tag]"]').val() || $('.fTag em').text(),
        tagin = $(this).text();
        
    var reg = new  RegExp('((or|and|or not|and not|not) )* ?"'+tagin+'"', 'ig');
    if(tagstr.match(reg)){
        tagstr = tagstr.replace(reg,'');
    }else{
        tagstr = tagstr + (tagstr.length ? ' or ' : '') + '"'+tagin+'"';
    }

    tagstr = tagstr.replace(/^\s*(and|or)\s*|\s*(and|or|not)\s*$/i,'');
    
    var fil = $('<input type="hidden" name="filter[tag]" value="">').val(tagstr);
    if (filter(fil)) {
        if ($('a.tload.selected').length > 0) {
            $('a.tload.selected').clone(true).removeClass('tstyled').attr('href', $('a.tload.selected').attr('href') + '&filter[tag]=' + tagstr).click();
            $('#content_tb').addClass('searchon');
            $('.freseter').css({
                display: 'inline'
            });
        } else {
            $('<form action="?cmd=tickets" method="post">' + fil + '</form>').appendTo('body').submit();
        }
    }
    $('.fTag em').text(tagstr).parent().show();
    $('input[name="filter[tag]"]').val(tagstr);
});
$(document).delegate('a.freseter', 'mousedown', function() {
    $('.fTag em').html('').parent().hide();
});
$(document).delegate('.filterform input[type="submit"]:first', 'click', function() {
    if ($(this).parents('form')[0]['filter[tag]'].value)
        $('.fTag em').text($(this).parents('form')[0]['filter[tag]'].value).parent().show();
});
$(function() {
    $('.tload').click(function() {
        if (this.id == '' || $('#list' + this.id).is(':visible'))
            return;
        $('.leftNav div[id^="listdept_"]').slideUp();
        $('#list' + this.id).slideDown();
    });
    $.post('?cmd=tickets', {
        action: 'listtags'
    }, function(data) {
        ticket.updateTags(data.tags)
    });
});
ticket = {
    updteStat: function(data) {
        $('.leftNav .msg_counter[id]').each(function(i) {
            var that = $(this),
                    id = that.attr('id').replace('ticketsn_', ''),
                    part = id.split('_');
            if (data[id] && data[id].total && data[id].total != '0') {
                that.html('(' + data[id].total + ')').show();
            } else if (part.length > 1 && data[part[1]] && data[part[1]][part[0]] && data[part[1]][part[0]] != '0') {
                that.html('(' + data[part[1]][part[0]] + ')').show();
            } else {
                that.hide();
            }
        })
        if(data.tags)
            ticket.updateTags(data.tags)
    },
    loadBulkActions: function() {

    },
    showMatchingTags: function(list, str, max) {
        $(list).html('').hide();
        if (max == undefined)
            max = 10;
        var i = 0, r = 0;
        var rbox = $(list);
        do {
            var spans = $('#tagsBox span.tag' + i++);
            spans.each(function() {
                var tag = this.innerHTML;
                if ((str == undefined || str.length < 1 || tag.match(new RegExp('^' + str + '.*$'))) && $('span a:first-child', rbox.parent().parent()).filter(function() {
                    return tag == $(this).text()
                }).length == 0 && (max == 0 || r < max)) {
                    rbox.append('<li>' + this.innerHTML + '</li>');
                    r++;
                }
            });

            rm = max > 0 ? r < max : true;
        } while (spans.length && rm);

        if ($('li', $(list)).length)
            $(list).show();
        $('body').bind('mouseout mousein', function(e) {
            if ($(e.target).parents('label').filter($(list).parents('label')).length == 0 && $(e.target).attr('id') != 'tagsCont') {
                if (ticket.hideTagsTimeout == null)
                    ticket.hideTagsTimeout = setTimeout(function() {
                        $(list).hide();
                        $('body').unbind('mouseout mousein');
                    }, 400);
            } else {
                clearTimeout(ticket.hideTagsTimeout);
                ticket.hideTagsTimeout = null;
            }
        });
    },
    hideTagsTimeout: null,
    insertTags: function(to, tags, special, preserve, wraperclass) {
        if (wraperclass === undefined)
            wraperclass = 'tag';
        var cls = '.' + wraperclass;
        var old = {};
        if (typeof preserve == 'undefined') {
            $('span' + cls + ':not(:has(a:first-child[class]))', to).remove();
            $('span' + cls, to).each(function() {
                old[$(this).find('a:first-child').text()] = $(this).detach()
            });
        }
        $.each(tags, function(i) {
            if (typeof old[tags[i]] == 'object') {
                if ($('span' + cls + ' a:first-child[class]', to).length)
                    $('span' + cls + ':has(a:first-child[class]):last', to).after(old[tags[i]]);
                else
                    $(to).prepend(old[tags[i]]);
                return;
            }
            var clas = '';
            if (typeof special != 'undefined' && typeof special[tags[i]] != 'undefined') {
                clas = 'class="' + special[tags[i]] + '"'
            }
            $('label', to).before('<span class="' + wraperclass + '"><a ' + clas + '>' + tags[i] + '</a> |<a class="cls">x</a></span>');
        });
    },
    bindTagsActions: function(root, tip, oninsert, onremove) {

        $(root + ' input').bind('focus click', function() {
            $(this).css({
                filter: 'alpha(opacity=100)',
                opacity: '1'
            });
            setTimeout('ticket.showMatchingTags("' + root + ' ul","' + this.value + '",' + tip + ')', 100);
        }).blur(function() {
            if (this.value.length == 0)
                $(this).css({
                    filter: 'alpha(opacity=80)',
                    opacity: '0.8'
                });
        });

        $(root).undelegate('input', 'keydown').delegate('input', 'keydown', function(event) {
            if (event.keyCode == 13) {
                event.preventDefault();
                return false;
            }
        }).undelegate('input', 'keyup').delegate('input', 'keyup', function(e) {
            ticket.showMatchingTags(root + ' ul', this.value, tip);
            if (this.value.length == 0)
                return;
            if (e.which == 13) {
                e.preventDefault();
                var tag = $.trim(this.value).replace(/[#$%^&*(){}~`\[\]:;"'?|+\/><,]/g, '');
                if (tag.length == 0)
                    return;
                if ($(root + ' span a:first-child').filter(function() {
                    return this.innerHTML == tag
                }).length > 0)
                    return;
                tag = $('<i/>').text(tag).html();
                ticket.insertTags(root, [tag], [], true);
                //$(this).parent().before('<span class="tag"><a>'+tag+'</a> |<a class="cls">x</a></span> ');
                if (typeof oninsert == 'function')
                    oninsert(tag);
                //$.post('?cmd=tickets&action=addtag', {tag:tag, id:$('#ticket_number').val()}, function(data){updateTags(data.tags)});
                this.value = '';
                ticket.showMatchingTags(root + ' label ul', '', tip);
            }
            return false;
        });
        $(root + ' ul').undelegate('li', 'click').delegate('li', 'click', function() {
            var ev = jQuery.Event("keyup");
            ev.which = 13;
            $(root + ' input').val(this.innerHTML).trigger(ev);

        });
        $(root).undelegate('span a:last-child', 'click').delegate('span a:last-child', 'click', function() {
            if ($(this).prev('a').hasClass('shared')) {
                if (!confirm(lang.unshare_confirm)) {
                    return false;
                }
            }
            $(this).parent().remove();
            if (typeof onremove == 'function')
                onremove($(this).siblings().text());
            //$.post('?cmd=tickets&action=removetag', { tag: $(this).siblings().text(), id:$('#ticket_number').val()}, function(data){if(typeof data != 'undefined' && typeof data.reloadwhole != 'undefined' && data.reloadwhole == true){ ajax_update('?cmd=tickets&action=view&list=all&num='+$('#ticket_number').val(),{},'#bodycont');}else if(typeof data != 'undefined'){updateTags(data.tags);if(data.tickettags !== undefined){insertTags(data.tickettags);}}});
        });
        $(document).undelegate(root, 'click').delegate(root, 'click', function(e) {
            if ($(e.target).is(root))
                $('label input', this).focus();
        });
    },
    alignColumns: function() {
        var sub = $('.view2048').length,
                cols = $('.tviews:not(.view2048)').filter(function() {
            return !$(this).attr('width')
        });

        cols.each(function(no) {
            var that = $(this),
                    index = that.index() + 1,
                    elems = that.parents('table').eq(0).find('td:nth-child(' + index + '), th:nth-child(' + index + ')'),
                    width = 0;
                    
            elems.each(function() {
                var self = $(this),
                    tag = self.children('.inlineTags'),
                    lwidth = 0;
                if(tag.length){
                    lwidth = self.children().width();
                }else{
                    lwidth = self.wrapInner('<span></span>').children().width();
                    self.children().children().unwrap();
                }
                if (lwidth > width)
                    width = lwidth;
            });
            if (sub || no)
                that.width(width + 10);
        });
    },
    autopoll: true,
    ticketpoll: false,
    initPoll: function() {
        //changed from interval to timeout
        //slow responses would start to flood
        clearTimeout(ticket.ticketpoll)
        ticket.ticketpoll = setTimeout(function() {
            ticket.poll(ticket.autopoll);
        }, 15000);
    },
    poll: function() {
        if ( $('a.selected', '#content_tb').attr('rel')) {
            //if ($('.freseter:visible').length > 0)
            //    return true;
            var dept_id = $('.selected', '.leftNav').parent('div').length ? $('div:has(.selected)', '.leftNav').attr('id') : $('.selected', '.leftNav').attr('id');
            if(!dept_id){
                autopoll = true;
                return false;
            }
            
             $.post('?cmd=tickets', {
                id: $('#ticket_number').val(),
                make: 'poll',
                page: parseInt($('.pagination span.current', '#testform').eq(0).html()) - 1,
                action: 'menubutton',
                body: $('#replyarea').val(),
                list: $('a.selected', '#content_tb').length ? $('a.selected', '#content_tb').attr('rel') : 'all',
                dept: dept_id.match(/\d*$/),
                assigned: $('#dept_my').hasClass('selected') ? 1 : $('a.selected', '#content_tb').parent('#listdept_my,#dept_my').length ? 1 : 0
            }, function(data) {
                if (typeof data != 'object') {
                    var checks = $('#updater input:checked'),
                        htm = parse_response(data);
                    
                    $('#updater').html($(htm).find('input[type=checkbox]').filter(function(){
                        return !!checks.filter('input[value='+$(this).val()+']').length
                    }).prop('checked', true).each(checkEl).end().end());
                    ticket.initPoll();
                    return false;
                }
                if (data.draftsave) {
                    $('#draftinfo .draftdate').html(lang["draftsavedat"] + " " + data.draftsave);
                }
                if (data.adminreply) {
                    if ($('.adminr_' + data.adminreply.replier_id).length < 1)
                        $('#alreadyreply').append("<span class=\"numinfos adminr_" + data.adminreply.replier_id + "\"><strong>" + data.adminreply.name + "</strong> " + lang["startedreplyat"] +                        " " + data.adminreply.date + "  <a href=\"#\" onclick=\"loadReply('" + data.adminreply.id + "');return false\">" + lang["preview"] + "</a> </span>");
                }
                if (data.newreply) {
                    $('#justadded').ShowNicely();
                }
                if (data.tags) {
                    ticket.updateTags(data.tags);
                }
                ticket.initPoll();
            });
        }else{
            ticket.initPoll();
        }
    },
    updateTags: function(tags) {
        var box = $('#tagsBox');
        box.html('');
        if (tags == undefined || tags.length < 1) {
            box.parents('.tagNav').hide();
            return;
        }
        for (var i = 0; i < tags.length; i++) {
            box.append('<span class="tag' + tags[i].group + '" style="opacity:' + tags[i].usage + '; filter: alpha(opacity = ' + (tags[i].usage * 100) + ');">' + tags[i].tag + '</span> ');
        }
        box.parents('.tagNav').show();
    },
    savedraft: function() {
        ajax_update('?cmd=tickets', {make: 'savedraft', action: 'menubutton', id: $('#ticket_number').val(), body: $('#replyarea').val()}, '#draftinfo .draftdate');
        $('#draftinfo .draftdate').show();
        return false;
    },
    removedraft: function() {
        ajax_update('?cmd=tickets', {make: 'removedraft', action: 'menubutton', id: $('#ticket_id').val()});
        $('#draftinfo .draftdate').html('').hide();
        $('#draftinfo .controls').hide();
        $('#replyarea').val("");
        return false;
    },
    loadReply: function(id) {
        $.post('?cmd=tickets', {make: 'loadreply', action: 'menubutton', id: id}, function(data) {
            if (data.reply) {
                $('#previewinfo .left').html(data.reply);
                $('#previewinfo').show();
            }
        });
    },
    getBilling: function() {
        $.get('?cmd=tickettimetracking&action=ticket&init=1&id=' + $('#ticket_id').val(), function(data) {
            $('#ticketbils > .ticket-msgbox').html(parse_response(data))
        });
    },
    addBilling: function() {
        var data = $('input, select, textarea', '#ticketbils').serializeObject();
        data.add = true;
        $.post('?cmd=tickettimetracking&action=ticket&id=' + $('#ticket_id').val(), data, function(data) {
            $('#ticketbils > .ticket-msgbox').html(parse_response(data))
        })
    },
    delBilling: function(id) {
        $.post('?cmd=tickettimetracking&action=ticket&id=' + $('#ticket_id').val(), {delete: id}, function(data) {
            $('#ticketbils > .ticket-msgbox').html(parse_response(data))
        })
    },
    startBilling: function(type, service){
        $.post('?cmd=tickettimetracking&action=ticket&id=' + $('#ticket_id').val(), {start: true, type: type, service: service}, function(data) {
            $('#ticketbils > .ticket-msgbox').html(parse_response(data))
        })
    },
}


function repozition() {
    $('.bottom-fixed .ticketsTags ul').css({
        left: -$('.bottom-fixed .ticketsTags label').position().left - 2,
        bottom: $('.bottom-fixed .ticketsTags').height()
    });
}

function reset_bulk() {
    $('.bottom-fixed .ticketsTags select, .bottom-fixed input, .bottom-fixed textarea').each(function() {
        if ($(this).is('[type="checkbox"]'))
            $(this).attr('checked', false);
        else
            $(this).val('').filter('textarea').text('').hide();
    });
    $('.bottom-fixed .ticketsTags .tag').remove();
    $('.hasMenu span').text(lang.nochange).eq(0).text(lang.none);
}

function showhide_bulk() {
    setTimeout(function() {
        if ($('#testform input.check:checked').length == 0) {
            $('.bottom-fixed').slideUp('fast', reset_bulk)
        } else
            $('.bottom-fixed').slideDown();
    }, 100);
}

function dropdown_handler(a, o, p, h) {
    o.children('span').text(h).end().children('input').val(a);
    if (o.is('#bulk_macro')) {
        $.get('?cmd=predefinied&action=getmacro&id=' + a, function(resp) {
            if (resp.macro.errors != undefined) {
                // handle errors;
            } else {
                for (var key in resp.macro) {
                    switch (key) {
                        case 'reply':
                            if (resp.macro[key] != null && resp.macro[key].length) {
                                $('input[name="bulk_reply"]').attr('checked', true);
                                $('textarea[name="bulk_message"]').slideDown().val(resp.macro[key]);
                            }
                            break;
                        case 'tags':
                            if (resp.macro[key] != null && ticket != undefined && typeof ticket.insertTags == 'function') {
                                for (var i = 0; i < resp.macro.tags.length; i++) {
                                    var ev = jQuery.Event("keyup");
                                    ev.which = 13;
                                    $('input#tagsin').val(resp.macro.tags[i]).trigger(ev).val('').next('ul').hide();
                                }
                            }
                            break;
                        case 'status':
                            if (resp.macro[key] != null && $('#bulk_' + key + '_m').length) {
                                dropdown_handler(resp.macro[key], $('#bulk_' + key), {}, $('#bulk_' + key + '_m').find('a[href="' + resp.macro[key] + '"]').html());
                            }
                            break;
                        default:
                            if (resp.macro[key] != null && $('#bulk_' + key + '_m').length) {
                                dropdown_handler(resp.macro[key], $('#bulk_' + key), {}, $('#bulk_' + key + '_m').find('a[href="' + resp.macro[key] + '"]').html());
                            }
                    }
                }
            }
        });
    }
}