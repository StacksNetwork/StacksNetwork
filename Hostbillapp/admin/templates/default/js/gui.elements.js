(function(a){a.fn.dragsort=function(b){var c=a.extend({},a.fn.dragsort.defaults,b),d=[],e=null,f=null;this.each(function(b,g){a(g).is("table")&&a(g).children().size()==1&&a(g).children().is("tbody")&&(g=a(g).children().get(0));var h={draggedItem:null,placeHolderItem:null,pos:null,offset:null,offsetLimit:null,container:g,init:function(){a(this.container).attr("listIdx",b).mousedown(this.grabItem)},grabItem:function(b){if(b.button!=2&&!a(b.target).is(c.dragSelectorExclude)){var f=b.target;while(!a(f).is("[listIdx="+a(this).attr("listIdx")+"] "+c.dragSelector)){if(f==this)return;f=f.parentNode}e!=null&&e.draggedItem!=null&&e.dropItem(),e=d[a(this).attr("listIdx")],e.draggedItem=a(f).closest(c.itemSelector);var g=parseInt(e.draggedItem.css("marginTop")),h=parseInt(e.draggedItem.css("marginLeft"));e.offset=e.draggedItem.offset(),e.offset.top=b.pageY-e.offset.top+(isNaN(g)?0:g)-1,e.offset.left=b.pageX-e.offset.left+(isNaN(h)?0:h)-1;if(!c.dragBetween){var i=a(e.container).outerHeight()==0?Math.max(1,Math.round(.5+a(e.container).children(c.itemSelector).size()*e.draggedItem.outerWidth()/a(e.container).outerWidth()))*e.draggedItem.outerHeight():a(e.container).outerHeight();e.offsetLimit=a(e.container).offset(),e.offsetLimit.right=e.offsetLimit.left+a(e.container).outerWidth()-e.draggedItem.outerWidth(),e.offsetLimit.bottom=e.offsetLimit.top+i-e.draggedItem.outerHeight()}e.draggedItem.css({position:"absolute",opacity:.8,"z-index":999}).after(c.placeHolderTemplate),e.placeHolderItem=e.draggedItem.next().css("height",e.draggedItem.height()).attr("placeHolder",!0),a(d).each(function(a,b){b.ensureNotEmpty(),b.buildPositionTable()}),e.setPos(b.pageX,b.pageY),a(document).bind("selectstart",e.stopBubble),a(document).bind("mousemove",e.swapItems),a(document).bind("mouseup",e.dropItem);return!1}},setPos:function(b,d){var e=d-this.offset.top,f=b-this.offset.left;c.dragBetween||(e=Math.min(this.offsetLimit.bottom,Math.max(e,this.offsetLimit.top)),f=Math.min(this.offsetLimit.right,Math.max(f,this.offsetLimit.left))),this.draggedItem.parents().each(function(){if(a(this).css("position")!="static"&&(!a.browser.mozilla||a(this).css("display")!="table")){var b=a(this).offset();e-=b.top,f-=b.left;return!1}}),this.draggedItem.css({top:e,left:f})},buildPositionTable:function(){var b=this.draggedItem==null?null:this.draggedItem.get(0),d=[];a(this.container).children(c.itemSelector).each(function(c,e){if(e!=b){var f=a(e).offset();f.right=f.left+a(e).width(),f.bottom=f.top+a(e).height(),f.elm=e,d.push(f)}}),this.pos=d},dropItem:function(){if(e.draggedItem!=null){e.placeHolderItem.before(e.draggedItem),e.draggedItem.css({position:"",top:"",left:"",opacity:"","z-index":""}),e.placeHolderItem.remove(),a("*[emptyPlaceHolder]").remove(),c.dragEnd.apply(e.draggedItem),e.draggedItem=null,a(document).unbind("selectstart",e.stopBubble),a(document).unbind("mousemove",e.swapItems),a(document).unbind("mouseup",e.dropItem);return!1}},stopBubble:function(){return!1},swapItems:function(b){if(e.draggedItem==null)return!1;e.setPos(b.pageX,b.pageY);var g=e.findPos(b.pageX,b.pageY),h=e;for(var i=0;g==-1&&c.dragBetween&&i<d.length;i++)g=d[i].findPos(b.pageX,b.pageY),h=d[i];if(g==-1||a(h.pos[g].elm).attr("placeHolder"))return!1;f==null||f.top>e.draggedItem.offset().top||f.left>e.draggedItem.offset().left?a(h.pos[g].elm).before(e.placeHolderItem):a(h.pos[g].elm).after(e.placeHolderItem),a(d).each(function(a,b){b.ensureNotEmpty(),b.buildPositionTable()}),f=e.draggedItem.offset();return!1},findPos:function(a,b){for(var c=0;c<this.pos.length;c++)if(this.pos[c].left<a&&this.pos[c].right>a&&this.pos[c].top<b&&this.pos[c].bottom>b)return c;return-1},ensureNotEmpty:function(){if(c.dragBetween){var b=this.draggedItem==null?null:this.draggedItem.get(0),d=null,e=!0;a(this.container).children(c.itemSelector).each(function(c,f){a(f).attr("emptyPlaceHolder")?d=f:f!=b&&(e=!1)}),e&&d==null?a(this.container).append(c.placeHolderTemplate).children(":last").attr("emptyPlaceHolder",!0):!e&&d!=null&&a(d).remove()}}};h.init(),d.push(h)});return this},a.fn.dragsort.defaults={itemSelector:"li",dragSelector:"li",dragSelectorExclude:"input, a[href]",dragEnd:function(){},dragBetween:!1,placeHolderTemplate:"<li>&nbsp;</li>"}})(jQuery);
(function ($) {
    $.facebox = function (data, klass) {
        $.facebox.loading(data.opacity);
        if(data.nofooter) {
            $('#facebox .footer').remove();
        }
        if (data.width) {
            $('#facebox .body').width(data.width)
        }
         if(data.addclass) {
            $('#facebox').addClass(data.addclass);
        }
        if (data.ajax) {
            fillFaceboxFromAjax(data.ajax)
        } else if (data.image) {
            fillFaceboxFromImage(data.image)
        } else if (data.div) {
            fillFaceboxFromHref(data.div)
        } else if ($.isFunction(data)) {
            data.call($)
        } else {
            $.facebox.reveal(data, klass)
        }
        
    };
    $.extend($.facebox, {
        settings: {
            opacity: 0.2,
            overlay: true,
            loadingImage: 'templates/default/js/facebox/loading.gif',
            closeImage: 'templates/default/js/facebox/closelabel.gif',
            imageTypes: ['png', 'jpg', 'jpeg', 'gif'],
            faceboxHtml: '<div id="facebox" style="display:none;"><div class="popup"><table><tbody><tr><td class="tl"/><td class="b"/><td class="tr"/></tr><tr><td class="b"/><td class="body"><div class="content"></div><div class="footer"><a href="#" class="close"><img src="templates/default/js/facebox/closelabel.gif" title="close" class="close_image" /></a></div></td><td class="b"/></tr><tr><td class="bl"/><td class="b"/><td class="br"/></tr></tbody></table></div></div>'
        },
        loading: function (opacity) {
            init();
            if ($('#facebox .loading').length == 1) {
                return true
            }
            showOverlay(opacity);
            $('#facebox .content').empty();
            $('#facebox .body').children().hide().end().append('<div class="loading"><img src="' + $.facebox.settings.loadingImage + '"/></div>');
            $('#facebox').css({
                top: getPageScroll()[1] + (getPageHeight() / 10),
                left: 385.5
            }).show();
            $(document).bind('keydown.facebox', function (e) {
                if (e.keyCode == 27) {
                    $.facebox.close()
                }
                return true
            });
            $(document).trigger('loading.facebox')
        },
        reveal: function (data, klass) {
            $(document).trigger('beforeReveal.facebox');
            if (klass) {
                $('#facebox .content').addClass(klass)
            }
            $('#facebox .content').append(data);
            $('#facebox .loading').remove();
            $('#facebox .body').children().fadeIn('normal');
            $('#facebox').css('left', $(window).width() / 2 - ($('#facebox table').width() / 2));
            $(document).trigger('reveal.facebox').trigger('afterReveal.facebox')
        },
        close: function () {
            $(document).trigger('close.facebox');
            return false
        }
    });
    $.fn.facebox = function (settings) {
        init(settings);

        function clickHandler() {
            $.facebox.loading(true);
            var klass = this.rel.match(/facebox\[?\.(\w+)\]?/);
            if (klass) {
                klass = klass[1]
            }
            fillFaceboxFromHref(this.href, klass);
            return false
        };
        return this.click(clickHandler)
    };

    function init(settings) {
        if ($.facebox.settings.inited) {
            return true
        } else {
            $.facebox.settings.inited = true
        }
        $(document).trigger('init.facebox');
        var imageTypes = $.facebox.settings.imageTypes.join('|');
        $.facebox.settings.imageTypesRegexp = new RegExp('\.' + imageTypes + '$', 'i');
        if (settings) {
            $.extend($.facebox.settings, settings)
        }
        $('body').append($.facebox.settings.faceboxHtml);
        var preload = [new Image(), new Image()];
        preload[0].src = $.facebox.settings.closeImage;
        preload[1].src = $.facebox.settings.loadingImage;
        $('#facebox').find('.b:first, .bl, .br, .tl, .tr').each(function () {
            preload.push(new Image());
            preload.slice(-1).src = $(this).css('background-image').replace(/url\((.+)\)/, '$1')
        });
        $('#facebox .close').click($.facebox.close);
        $('#facebox .close_image').attr('src', $.facebox.settings.closeImage)
    };

    function getPageScroll() {
        var xScroll, yScroll;
        if (self.pageYOffset) {
            yScroll = self.pageYOffset;
            xScroll = self.pageXOffset
        } else if (document.documentElement && document.documentElement.scrollTop) {
            yScroll = document.documentElement.scrollTop;
            xScroll = document.documentElement.scrollLeft
        } else if (document.body) {
            yScroll = document.body.scrollTop;
            xScroll = document.body.scrollLeft
        }
        return new Array(xScroll, yScroll)
    };

    function getPageHeight() {
        var windowHeight;
        if (self.innerHeight) {
            windowHeight = self.innerHeight
        } else if (document.documentElement && document.documentElement.clientHeight) {
            windowHeight = document.documentElement.clientHeight
        } else if (document.body) {
            windowHeight = document.body.clientHeight
        }
        return windowHeight
    };

    function fillFaceboxFromHref(href, klass) {
        if (href.match(/#/)) {
            var url = window.location.href.split('#')[0];
            var target = href.replace(url, '');
            $.facebox.reveal($(target).clone().show(), klass)
        } else if (href.match($.facebox.settings.imageTypesRegexp)) {
            fillFaceboxFromImage(href, klass)
        } else {
            fillFaceboxFromAjax(href, klass)
        }
    };

    function fillFaceboxFromImage(href, klass) {
        var image = new Image();
        image.onload = function () {
            $.facebox.reveal('<div class="image"><img src="' + image.src + '" /></div>', klass)
        };
        image.src = href
    };

    function fillFaceboxFromAjax(href, klass) {
        $.get(href, function (data) {
            $.facebox.reveal(data, klass)
        })
    };

    function skipOverlay() {
        return $.facebox.settings.overlay == false || $.facebox.settings.opacity === null
    };

    function showOverlay(opacity) {
        if (skipOverlay()) {
            return
        }
        if ($('facebox_overlay').length == 0) $("body").append('<div id="facebox_overlay" class="facebox_hide"></div>');
        $('#facebox_overlay').hide().addClass("facebox_overlayBG").css('opacity', opacity?opacity: $.facebox.settings.opacity).click(function () {
            $(document).trigger('close.facebox')
        }).fadeIn(200);
        return false
    };

    function hideOverlay() {
        if (skipOverlay()) {
            return
        }
        $('#facebox_overlay').fadeOut(200, function () {
            $("#facebox_overlay").removeClass("facebox_overlayBG");
            $("#facebox_overlay").addClass("facebox_hide");
            $("#facebox_overlay").remove()
        });
        return false
    };
    $(document).bind('close.facebox', function () {
        $(document).unbind('keydown.facebox');
        $('#facebox').fadeOut(function () {
            $('#facebox .content').removeClass().addClass('content');
            hideOverlay();
            $('#facebox .loading').remove()
        })
    })
})(jQuery);