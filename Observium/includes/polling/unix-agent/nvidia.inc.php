<?php

global $agent_sensors;

if ($agent_data['nvidia']['smi'] != '')
{
  $nvidia = parse_csv($agent_data['nvidia']['smi']);
  if (count($nvidia))
  {
    echo "nvidia-smi: ";
    foreach ($nvidia as $card)
    {
/*
Currently not used:

[fan.speed [%]] => 66 %
[utilization.gpu [%]] => [Not Supported]
[utilization.memory [%]] => [Not Supported]
*/
      if ($card['temperature.gpu'] != '[Not Supported]')
      {
        discover_sensor($valid['sensor'], 'temperature', $device, '', $card['index'], 'nvidia-smi', "Nvidia Card ".($card['index']+1).": ".$card['name'], '1', '1', NULL, NULL, NULL, 100, $card['temperature.gpu'], 'agent');
        $agent_sensors['temperature']['nvidia-smi'][$card['index']] = array('description' => "Nvidia Card ".($card['index']+1).": ".$card['name'], 'current' => $card['temperature.gpu'], 'index' => $card['index']);
      }

      if ($card['power.draw [W]'] != '[Not Supported]')
      {
        discover_sensor($valid['sensor'], 'power', $device, '', $card['index'], 'nvidia-smi', "Nvidia Card ".($card['index']+1).": ".$card['name'], '1', '1', NULL, NULL, NULL, NULL, $card['power.draw [W]'], 'agent');
        $agent_sensors['power']['nvidia-smi'][$card['index']] = array('description' => "Nvidia Card ".($card['index']+1).": ".$card['name'], 'current' => $card['power.draw [W]'], 'index' => $card['index']);
      }
    }
    echo "\n";
  }
}

// EOF
