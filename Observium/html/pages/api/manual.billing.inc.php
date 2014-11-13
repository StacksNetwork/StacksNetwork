<div class="row">
  <div class="col-md-12 well">
    <h3>Billing:</h3>
    <p>
      With this module it is possible to export the raw traffic data that
      is stored in the mysql database.
    </p>
    <dl>
      <dt>bill</dt>
      <dd>The bill id of the bill you want to grab the traffic information from</dd>
      <dt>type</dt>
      <dd>Type of data collection (traffic|history|list)
      <dt>group</dt>
      <dd>Group traffic collection (hour|day|week|month)
      <dt>from</dt>
      <dd>From timestamp, the start date from where you want to start the data collection</dd>
      <dt>to</dt>
      <dd>To timestamp, the end data from where you want to stop the data collection</dd>
    </dl>
    <pre>
      <strong>Explaination:</strong> Collect the traffic data from yesterday until now
      <strong>Example 1   :</strong> http://<?php echo($_SERVER['SERVER_NAME']); ?>/api.php?username=demo&password=demo&module=billing&bill=1&from=<?php echo $config['time']['day']; ?>&to=<?php echo $config['time']['now']; ?>&type=traffic
      <strong>Result      :</strong> [JSON DATA]</pre>
    <pre>
      <strong>Explaination:</strong> Collect the traffic data from last month until last week grouped per day
      <strong>Example 2   :</strong> http://<?php echo($_SERVER['SERVER_NAME']); ?>/api.php?username=demo&password=demo&module=billing&bill=1&from=<?php echo $config['time']['month']; ?>&to=<?php echo $config['time']['week']; ?>&type=traffic&group=day
      <strong>Result      :</strong> [JSON DATA]</pre>
    <pre>
      <strong>Explaination:</strong> Collect the historical data
      <strong>Example 3   :</strong> http://<?php echo($_SERVER['SERVER_NAME']); ?>/api.php?username=demo&password=demo&module=billing&bill=1&type=historical
      <strong>Result      :</strong> [JSON DATA]</pre>
    <pre>
      <strong>Explaination:</strong> Collect the billing list
      <strong>Example 4   :</strong> http://<?php echo($_SERVER['SERVER_NAME']); ?>/api.php?username=demo&password=demo&module=billing&type=list
      <strong>Result      :</strong> [JSON DATA]</pre>
  </div>
</div>

