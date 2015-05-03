<h2 title="描述您的主机负载的响比和网站的加载速度." class="left havetooltip">响应比 <strong class="availability"></strong>%</h2>
<div class="clear"></div>
<div id="responsivenessGraph" class="graph adjustedOnDateNavigation"></div>
<script>{literal}
jQuery(document).ready(function($) {
  var refreshResponsivenessGraph = function() {
    var responsivenessData = [];
    var minResponsiveness = Infinity;
    $.each(dateInterval.stats, function(index, stat) {
      var responsiveness = stat.responsiveness || (stat.isResponsive ? 100 : 0);
      responsivenessData.push([new Date(stat.timestamp), responsiveness]);
      minResponsiveness = Math.min(minResponsiveness, responsiveness);
    });
    var container = $('#responsivenessGraph').get(0);
    Flotr.draw(container, [{ data: responsivenessData, color: '#9440ED', lines: { show: true, lineWidth: 4 }, points: { show: true } }], { 
      yaxis : {
        min : 0,
        margin: false,
        min: minResponsiveness < 10 ? minResponsiveness : minResponsiveness < 90 ? minResponsiveness - 10 : (minResponsiveness - 1),
        max: 100
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
          return moment(obj.x).format('LLLL') + '<br/><strong>' + obj.y + '%</strong>';
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
  dateInterval.on('refresh-stats', refreshResponsivenessGraph);
});
</script>
{/literal}