$(function() {

    var active = false;
    $('.plan-box').each(function(index, element) {
        var h = $(this).height();
        $(this).find('.hidden-info').height(h);
        animateOut($(this));
    });

    $('.plan-box').hover(function() {
        if (!active) {
            animateIn($(this));
        }
    }, function() {
        if (!active) {
            animateOut($(this));
        }
    });


    $('.plan-box').find('a').click(function(e) {
        var that = $(this).parents('.plan-box');
        var ref = $('.plan-box.active');

        $('.plan-box').removeClass('active');
        that.addClass('active');
        active = true;
        ref.find('a').text('Select');
        $(this).text('Selected');

        var pid = $(this).attr('data-value');
        $('#flavor_id').val(pid);

        e.stopImmediatePropagation();
        animateOut(ref);
        animateIn(that);

        return false;
    });






    function animateIn(that)
    {
        var bodyH = that.find('.plan-body').innerHeight();
        var headerH = that.find('.plan-header').innerHeight();
        var h3 = that.find('h3').height();
        var priceH = that.find('h3').next().height();

        that.find('.header-hover').animate({'height': headerH + bodyH}, {
            duration: 300,
            queue: false,
        });
        that.find('.header-hover').next().animate({'top': headerH - (h3 + priceH + 5)}, 300);

        that.find('.text-fade').fadeIn(500);

        if (that.hasClass('left-hover')) {
            that.find('.hidden-info').css('display', 'block').animate({'right': 300, 'left': 'auto'}, 300);
        } else {
            that.find('.hidden-info').css('display', 'block').animate({'left': 300}, 300);
        }


        that.find('.plan-body').find('.padding').css('opacity', 0.7);

    }


    function animateOut(that)
    {
        that.find('.header-hover').next().animate({'top': 0}, {
            duration: 300,
            queue: false,
            complete: function() {
                $(this).prev().animate({'height': 0}, 300);
            }});

        that.find('.text-fade').fadeOut(500);

        if (that.hasClass('left-hover')) {
            that.find('.hidden-info').animate({'right': 0}, 300, function() {
                $(this).css('display', 'none');
            });
        } else {
            that.find('.hidden-info').animate({'left': 0}, 300, function() {
                $(this).css('display', 'none');
            });
        }


        $('.plan-box .plan-body .padding').css('opacity', 1);
    }


});

