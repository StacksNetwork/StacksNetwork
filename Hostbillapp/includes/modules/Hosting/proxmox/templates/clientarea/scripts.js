function powerchange(el,warn) {
    if($(el).hasClass('iphone_switch_container_on')) {
        if(confirm(warn)) {
            $(el).removeClass('iphone_switch_container_on').addClass('iphone_switch_container_off');
            return true;
        }
    } else if ($(el).hasClass('iphone_switch_container_off')) {
        if(confirm(warn)) {
            $(el).removeClass('iphone_switch_container_off').addClass('iphone_switch_container_on');
            return true;
        }

    }
    return false;
}
