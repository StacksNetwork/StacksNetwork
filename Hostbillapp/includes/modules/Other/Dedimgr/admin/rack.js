(function(g) {
    var f = {verticalOffset: 10, horizontalOffset: 10, title: !1, content: !1, url: !1, classes: "", position: "auto", fadeSpeed: 160, trigger: "click", preventDefault: !0, stopChildrenPropagation: !0, hideOnHTMLClick: !0, animateChange: !0, autoReposition: !0, anchor: !1}, j = [], i = {calc_position: function(r, q) {
            var k, a, p = r.popover("getData"), o = p.options, n = o.anchor ? g(o.anchor) : r, m = p.popover, l = n.offset();
            return"top" == q ? (k = l.top - m.outerHeight(), a = l.left - m.outerWidth() / 2 + n.outerWidth() / 2) : "right" == q ? (k = l.top + n.outerHeight() / 2 - m.outerHeight() / 2, a = l.left + n.outerWidth()) : "left" == q ? (k = l.top + n.outerHeight() / 2 - m.outerHeight() / 2, a = l.left - m.outerWidth()) : (k = l.top + n.outerHeight(), a = l.left - m.outerWidth() / 2 + n.outerWidth() / 2), x2 = a + m.outerWidth(), y2 = k + m.outerHeight(), ret = {x1: a, x2: x2, y1: k, y2: y2}
        }, pop_position_class: function(l, k) {
            var o = "popover-top popover-right popover-left", n = "top-arrow", m = "right-arrow bottom-arrow left-arrow";
            "top" == k ? (o = "popover-right popover-bottom popover-left", n = "bottom-arrow", m = "top-arrow right-arrow left-arrow") : "right" == k ? (o = "popover-yop popover-bottom popover-left", n = "left-arrow", m = "top-arrow right-arrow bottom-arrow") : "left" == k && (o = "popover-top popover-right popover-bottom", n = "right-arrow", m = "top-arrow bottom-arrow left-arrow"), l.removeClass(o).addClass("popover-" + k).find(".arrow").removeClass(m).addClass(n)
        }}, h = {init: function(a) {
            return this.each(function() {
                var m = g.extend({}, f, a), l = g(this), k = l.popover("getData");
                if (!k) {
                    var d = g('<div class="popover" />').addClass(m.classes).append('<div class="arrow" />').append('<div class="wrap"></div>').appendTo("body").hide();
                    m.stopChildrenPropagation && d.children().bind("click.popover", function(e) {
                        e.stopPropagation()
                    }), m.anchor && !m.anchor instanceof jQuery && (m.anchor = g(m.anchor));
                    var k = {target: l, popover: d, options: m};
                    if (m.title && g('<div class="title" />').html(m.title instanceof jQuery ? m.title.html() : m.title).appendTo(d.find(".wrap")), m.content && g('<div class="content" />').html(m.content instanceof jQuery ? m.content.html() : m.content).appendTo(d.find(".wrap")), l.data("popover", k), j.push(l), m.url && l.popover("ajax", m.url), l.popover("reposition"), l.popover("setTrigger", m.trigger), m.hideOnHTMLClick) {
                        var c = "click.popover";
                        "ontouchstart" in document.documentElement && (c = "touchstart.popover"), g("html").unbind(c).bind(c, function() {
                            g("html").popover("fadeOutAll")
                        })
                    }
                    if (m.autoReposition) {
                        var b = function() {
                            l.popover("reposition")
                        };
                        g(window).unbind("resize.popover").bind("resize.popover", b).unbind("scroll.popover").bind("scroll.popover", b)
                    }
                }
            })
        }, reposition: function() {
            return this.each(function() {
                var C = g(this), B = C.popover("getData");
                if (B) {
                    var A = B.popover, z = B.options, y = z.anchor ? g(z.anchor) : C;
                    y.offset();
                    var x = z.position;
                    "top" != x && "right" != x && "left" != x && "auto" != x && (x = "bottom");
                    var w;
                    if ("auto" == x) {
                        var v = ["bottom", "left", "top", "right"], u = g(window).scrollTop(), q = g(window).scrollLeft(), p = g(window).outerHeight(), d = g(window).outerWidth();
                        if (g.each(v, function(b, r) {
                            w = i.calc_position(C, r);
                            var o = w.x1 - q, n = w.x2 - q + z.horizontalOffset, m = w.y1 - u, l = w.y2 - u + z.verticalOffset;
                            return 0 > o || 0 > n || 0 > m || 0 > l ? !0 : l > p ? !0 : n > d ? !0 : (x = r, !1)
                        }), "auto" == x) {
                            return
                        }
                    }
                    w = i.calc_position(C, x), w.top, w.left, i.pop_position_class(A, x);
                    var a = 0, E = 0;
                    "bottom" == x && (a = z.verticalOffset), "top" == x && (a = -z.verticalOffset), "right" == x && (E = z.horizontalOffset), "left" == x && (E = -z.horizontalOffset);
                    var D = {left: w.x1, top: w.y1, marginTop: a, marginLeft: E};
                    B.initd && z.animateChange ? A.css(D) : (B.initd = !0, A.css(D)), C.data("popover", B)
                }
            })
        }, destroy: function() {
            return this.each(function() {
                var a = g(this), d = a.popover("getData");
                a.unbind(".popover"), g(window).unbind(".popover"), d.popover.remove(), a.removeData("popover")
            })
        }, show: function() {
            return this.each(function() {
                var a = g(this), k = a.popover("getData");
                if (k) {
                    var e = k.popover;
                    a.popover("reposition"), e.clearQueue().css({zIndex: 950}).show()
                }
            })
        }, hide: function() {
            return this.each(function() {
                var a = g(this), d = a.popover("getData");
                d && d.popover.hide().css({zIndex: 949})
            })
        }, fadeOut: function(a) {
            return this.each(function() {
                var m = g(this), l = m.popover("getData");
                if (l) {
                    var k = l.popover, b = l.options;
                    k.delay(100).css({zIndex: 949}).fadeOut(a ? a : b.fadeSpeed)
                }
            })
        }, hideAll: function() {
            return g.each(j, function() {
                var c = g(this), b = c.popover("getData");
                if (b) {
                    var a = b.popover;
                    a.hide()
                }
            })
        }, fadeOutAll: function(a) {
            return g.each(j, function() {
                var k = g(this), d = k.popover("getData");
                if (d) {
                    var c = d.popover, b = d.options;
                    c.css({zIndex: 949}).fadeOut(a ? a : b.fadeSpeed)
                }
            })
        }, setTrigger: function(a) {
            return this.each(function() {
                var n = g(this), m = n.popover("getData");
                if (m) {
                    var l = m.popover, k = m.options, b = k.anchor ? g(k.anchor) : n;
                    "click" === a ? (b.unbind("click.popover").bind("click.popover", function(c) {
                        k.preventDefault && c.preventDefault(), c.stopPropagation(), n.popover("show")
                    }), l.unbind("click.popover").bind("click.popover", function(c) {
                        c.stopPropagation()
                    })) : (b.unbind("click.popover"), l.unbind("click.popover")), "hover" === a ? (b.add(l).bind("mousemove.popover", function() {
                        n.popover("show")
                    }), b.add(l).bind("mouseleave.popover", function() {
                        n.popover("fadeOut")
                    })) : b.add(l).unbind("mousemove.popover").unbind("mouseleave.popover"), "focus" === a ? (b.add(l).bind("focus.popover", function() {
                        n.popover("show")
                    }), b.add(l).bind("blur.popover", function() {
                        n.popover("fadeOut")
                    }), b.bind("click.popover", function(c) {
                        c.stopPropagation()
                    })) : b.add(l).unbind("focus.popover").unbind("blur.popover").unbind("click.popover")
                }
            })
        }, title: function(a) {
            return this.each(function() {
                var m = g(this), l = m.popover("getData");
                if (l) {
                    var k = l.popover.find(".title"), b = l.popover.find(".wrap");
                    0 === k.length && (k = g('<div class="title" />').appendTo(b)), k.html(a)
                }
            })
        }, content: function(a) {
            return this.each(function() {
                var m = g(this), l = m.popover("getData");
                if (l) {
                    var k = l.popover.find(".content"), b = l.popover.find(".wrap");
                    0 === k.length && (k = g('<div class="content" />').appendTo(b)), k.html(a)
                }
            })
        }, ajax: function(a, d) {
            return this.each(function() {
                var l = g(this), k = l.popover("getData");
                if (k) {
                    var c = {url: a, success: function(e) {
                            var n = k.popover.find(".content"), m = k.popover.find(".wrap");
                            0 === n.length && (n = g('<div class="content" />').appendTo(m)), n.html(e)
                        }}, b = g.extend({}, c, d);
                    g.ajax(b)
                }
            })
        }, setOption: function(a, d) {
            return this.each(function() {
                var c = g(this), b = c.popover("getData");
                b && (b.options[a] = d, c.data("popover", b))
            })
        }, getData: function() {
            var a = [];
            return this.each(function() {
                var e = g(this), b = e.data("popover");
                b && a.push(b)
            }), 0 != a.length ? (1 == a.length && (a = a[0]), a) : void 0
        }};
    g.fn.popover = function(a) {
        return h[a] ? h[a].apply(this, Array.prototype.slice.call(arguments, 1)) : "object" != typeof a && a ? (g.error("Method " + a + " does not exist on jQuery.popover"), void 0) : h.init.apply(this, arguments)
    }
})(jQuery);

$(function() {

    $('.rack-mount').each(function() {
        var mount = $(this),
            side = mount.children(),
            units = $('#rowcols tr').length - 1;

        var getItemPos = function(e) {
            var ru = units + 1,
                    t = $(e),
                    right = side.is('.rack-side-r'),
                    indexlist = t.prevAll().map(function() {
                return parseInt($(this).attr('data-units')) || 1
            }),
                    pos = 0;
            for (var i = 0; i < indexlist.length; i++)
                pos += indexlist[i];
            return [ru - pos + (ru * (right ? t.parent().index() : t.parent().nextAll().length)) - 1, right ? 'Rside' : 'Lside'];
        }
        side.on('click', '.newitem', function(e) {
            addRItem.apply(this, getItemPos(this));
        })
        var sortback = false,
            place = false;
        side.sortable({
            start: function(e, ui) {
                ui.placeholder.width(ui.helper.width());
                side.addClass('ui-sortable-active');
            },
            change: function(e, ui) {
                var id = ui.item.attr('data-id'),
                    parent = ui.item.parent();

                side.find('.newitem').show();
                if (!ui.placeholder.parent().is(parent)) {
                    var u = parseInt(ui.item.attr('data-units'));
                    if (isNaN(u) || u < 1)
                        return false;

                    if (!place.length) {
                        var p = [], tu = u;
                        while (tu--)
                            p.push('<div class="newitem"></div>');
                        place = $(p.join('')).insertAfter(ui.item);
                    }

                    var f = ui.placeholder.nextAll().filter(function() {
                        return !$(this).is('.rackitem')
                    });
                    if (f.length < u) {
                        ui.item.parent().children().each(function(){
                            var t =$(this);
                            if(t.position().top > ui.position.top + t.width()/2 ){
                                ui.placeholder.insertAfter(t);
                                if(place) place.remove(); place = false;
                                return false
                            }
                        });
                    } else {
                        f.slice(0, u).hide();
                    }
                } else if (ui.placeholder.parent().is(parent) && place.length) {
                    if(place) place.remove(); place = false;
                }
            },
            update: function(e, ui) {
                var data = {
                    do: 'setnewpositions',
                    rack_id: $('#rack_id').val(),
                    vars: {},
                    location: 'None'
                };
                ui.item.parent().parent().find('.rackitem').each(function() {
                    var pos = getItemPos(this);
                    data.vars[pos[0]+1] = $(this).attr('data-id');
                    data.location = pos[1];
                })
                ajax_update('?cmd=module&module=dedimgr', data);
            }, stop: function(e, ui) {
                place = false;
                ui.item.parent().children().filter(function() {
                    return !$(this).is(':visible')
                }).remove();
                ui.item.addClass('aftersort');
                side.removeClass('ui-sortable-active');
                setTimeout(function() {
                    ui.item.removeClass('aftersort');
                }, 100);
            },
            helper: function() { return '<span></span>'},
            tolerance: "pointer",
            forcePlaceholderSize: true,
            cancel: '.rackitem-menu',
            items: '.col-group > div',
            zIndex: '100'
        });
    });

    $("#sortable").sortable({
        update: function(event, ui) {
            var total = $("#rowcols tr").length,
                    i = 0,
                    o = {},
                    size = 1;
            $("#sortable .dragdrop").each(function(n) {
                var that = $(this),
                        size = parseInt(that.attr('data-units')),
                        id = that.attr('data-id') || false;
                that.attr('data-position', total - i);
                if (id)
                    o[total - i] = id;
                i = i + size;
            });
            ajax_update('?cmd=module&module=dedimgr', {
                do: 'setnewpositions',
                rack_id: $('#rack_id').val(),
                vars: o
            });
        },
        handle: '.rackitem',
        start: function(e, ui) {
            ui.placeholder.height(ui.item.height());
        },
        stop: function(e, ui) {
            ui.item.find('.rackitem').addClass('aftersort');
            setTimeout(function() {
                ui.item.find('.rackitem').removeClass('aftersort');
            }, 100);
        }
    });

    $('.rackitem').each(function() {
        var that = $(this),
            itemlist = $('.rackitem');
        that.click(function(e) {
            if (that.is('.aftersort'))
                return false;
            if (!that.is('.active')){
                itemlist.removeClass('active');
                $('.rack-mount').removeClass('active');
            }
            that.toggleClass('active').parents('.rack-mount').toggleClass('active');
        }).hover(function() {
            if(that.parents('.ui-sortable-active').length)
                return false;
            if (!itemlist.filter('.active').length) {
                that.addClass('hover');
            }
        }, function() {
            that.removeClass('hover');
        });
    });
});

function initRack() {
    $('#rackview_switch').children().each(function(x) {
        $(this).click(function() {
            var that = $(this);
            $('#' + that.addClass('activated').siblings().removeClass('activated').each(function() {
                $('#' + $(this).attr('data-rel')).hide();
            }).end().attr('data-rel')).show();

            if (that.is('.activated'))
                $.get(that.attr('href'));
            return false;
        })
    }).filter('.activated').click();

    var unitSize = 20;
    $('.rackitem').bind('updateus', function() {
        var that = $(this),
                clsu = that.attr('class').match(/server(\d+)u/),
                us = clsu ? parseInt(clsu[1]) : 1,
                v = that.parent().is('.rack-row');
        if (v)
            that.height(us * unitSize);
        else
            that.width(us * unitSize);
    }).trigger('updateus');
    
    var sidelength = $('#rowcols td').length * unitSize;
    $('.rack-mount').each(function() {
        var mount = $(this),
            side = mount.children();

        if (side.is('.rack-side-r')) {
            side.append(side.children().detach().get().reverse())
        }
        side.children().each(function() {
            fitRackItems($('.rackitem', this).eq(0));
        })

        side.width(sidelength);
        mount.height(sidelength).width(side.children().length * (unitSize + 4));
    });

    fitRackItems('.rack-front tr.have_items:first');
}

function fitRackItems(item) {
    var rackitem = $(item);
    while (rackitem.length) {
        var u = parseInt(rackitem.attr('data-units')),
                i = rackitem.index();
        if (!isNaN(u)) {
            rackitem.nextAll(':lt(' + (u - 1) + ')').remove();
        }
        rackitem = rackitem.next();
    }
}

function addRItem(position, location) {
    location = location || 'Front';
    $.facebox({
        ajax: '?cmd=module&module=' + $('#module_id').val() + "&do=itemadder&rack_id=" + $('#rack_id').val() + "&position=" + position + '&location=' + location,
        width: 900,
        nofooter: true,
        opacity: 0.8,
        addclass: 'modernfacebox'
    });
    return false;
}

function expandRack(direction) {
    var target = $('.rack-side-' + direction);
    if (target.length) {
        var u = $("#rowcols tr").length,
                c = [];
        while (u--)
            c.push('<div class="newitem"></div>');
        target.append('<div class="col-group">' + c.join('') + '</div>').parent().width(target.parent().width() + 24);
    }

    return false;
}