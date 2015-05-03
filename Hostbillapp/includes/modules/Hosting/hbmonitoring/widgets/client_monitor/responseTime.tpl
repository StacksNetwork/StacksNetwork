<h2 title="描述的时间以毫秒(ms)为单位, 需要您的主机响应." class="left havetooltip">响应时间 <strong class="avgRespTime"></strong>ms</h2><div class="clear"></div>
<div id="responseTimeGraph" class="graph adjustedOnDateNavigation"></div>
<script>{literal}
jQuery(document).ready(function($) {
  var refreshResponseTimeGraph = function() {
    var responseTimes = [];
    $.each(dateInterval.stats, function(index, stat) {
      responseTimes.push([new Date(stat.timestamp), stat.responseTime || stat.time]);
    });
    var container = $('#responseTimeGraph').get(0);
    Flotr.draw(container, [{ data: responseTimes, color: '#4DA74D', lines: { show: true, lineWidth: 4 }, points: { show: true } }], { 
      yaxis : {
        min : 0,
        margin: false,
        autoscale: true
      },
      xaxis : {
        showLabels: false,
        noTicks: 0,
        mode: 'time',
        min: dateInterval.begin.valueOf() - dateInterval.getSubTypeDuration() / 2,
        max: dateInterval.end.valueOf() - dateInterval.getSubTypeDuration() / 2
      },
      mouse : {
        track: true,
        trackFormatter: function(obj) {
          return moment(obj.x).format('LLLL') + '<br/><strong>' + obj.y + 'ms</strong>';
        },
        relative: true,
        sensibility: 4,
        radius: 4,
        position: 's'
      },
      grid: { outline: '' }
    });
    Flotr.EventAdapter.observe(container, 'flotr:click', function (hit) {
      if (!hit.series || dateInterval.isMaxZoom()) return;
      dateInterval.update(dateInterval.subType(), hit.x);
    });

  }
  dateInterval.on('refresh-stats', refreshResponseTimeGraph);
});
</script>
{/literal}