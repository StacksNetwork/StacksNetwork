var updateCheckState = function(check) {
  var html = '';
  if (typeof check.isUp == 'undefined') {
    if (check.lastTested) {
      // recover from pause
      html += '<span class="label label-info">未知</span>';
    } else {
      // never tested
      html += '<span class="label label-important">异常</span>';
    }
  } else {
    var status = {};
    if (check.isPaused) {
      // paused
      status.label = 'info';
      status.color = 'blue';
      status.text = '停止';
      status.date = check.lastTested;
    } else if (check.isUp) {
      // up
      status.label = 'success';
      status.color = 'green';
      status.text = '正常';
      status.date = check.lastChanged;
    } else {
      // down
      status.label = 'important';
      status.color = 'red';
      status.text = '异常';
      status.date = check.lastChanged;
    }
    html += '<span class="label label-' + status.label + '">' +  status.text +'</span>'
    html += '<span class="' + status.color + '"> 时间 <span title="' + new Date(status.date) + '">' + moment(status.date).fromNow(true) + '</span></span>';
  }
  $('#check_24h').html(html);
}