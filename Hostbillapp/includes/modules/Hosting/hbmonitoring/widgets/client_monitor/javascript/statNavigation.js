var StatNavigation = function(interval) {
  this.interval = interval;
  this.init();
}
StatNavigation.prototype.init = function() {
  this.interval.on('refresh-stat', function() {
    var stat = this.stat;
    if (stat && stat.availability) {
      $('.availability').text(stat.availability.replace('.000', ''));
      $('.responsiveness').text(stat.responsiveness.replace('.000', ''));
      $('.avgRespTime').text(stat.responseTime);
      
    }
  });
  
}