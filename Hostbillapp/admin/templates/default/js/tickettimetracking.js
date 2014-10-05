
var timepickers = $('.timepicker');
var datepicker = $('.haspicker');

datepicker.datePicker({
    startDate: startDate
});
timepickers.timepicker({
    timeFormat: 'H:i',
    showDuration: true
}).eq(0).on('changeDate change', function(x) {
    timepickers.eq(1).timepicker('option', 'minTime', $(this).timepicker('getTime'))
}).end().eq(1).on('changeDate change', function(x) {
    var end = $(this).timepicker('getTime'),
            start = timepickers.eq(0).timepicker('getTime');

    if (end.getTime() - start.getTime() <= 0) {
        var date = getFieldDate(datepicker.eq(1)),
                date2 = getFieldDate(datepicker.eq(2)),
                days = (date.getDate() + 1).toString(),
                month = (date.getMonth() + 1).toString(),
                format = Date.format;
        if (!isNaN(date.getTime()) && (isNaN(date2.getTime()) || date.getTime() >= date2.getTime()))
            datepicker.eq(2).val(
                    format.replace('d', days.length < 2 ? "0" + days : days)
                    .replace('m', month.length < 2 ? "0" + month : month)
                    .replace('Y', date.getFullYear())
                    );
    }
});
datepicker.eq(1).change(function() {
    datepicker.eq(2).dpSetStartDate($(this).val());
});
function getFieldDate(datepicker) {
    var value = datepicker.val(),
            format = Date.format, delim = format.replace(/[^-\/\.]/g, '').charAt(0), parts = value.split(delim),
            formatparts = format.split(delim);
    return new Date(parts[formatparts.indexOf('Y')], parts[formatparts.indexOf('m')] - 1, parts[formatparts.indexOf('d')])
}
