<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage webui
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

if (isset($_POST['billsearch']))
{
  $where = " WHERE 1 ";
  $param = array();
  foreach ($_POST as $item=>$value)
  {
    if (!empty($value))
    {
      switch($item)
      {
        case "billingname":
          $where  .= " AND `bill_name` LIKE ?";
          $param[] = "%".$value."%";
          break;
        case "billingtype":
          if ($value == "cdr" || $value == "quota")
          {
            $where  .= " AND `bill_type` = ?";
            $param[] = $value;
          }
          break;
        /// TODO: FIX this to allow over and under usage
        /*
        case "billingstate":
          if ($value == "over") {
            $where  .= " OR `total_data_out` > `bill_quota` OR `rate_95th` > `bill_cdr`";
          } elseif ($value == "under") {
            $where  .= " OR `total_data_out` =< `bill_quota` OR `rate_95th` =< `bill_cdr`";
          }
          break;
        */
        case "billinguser":
          $first = true;
          $where      .= " AND (";
          foreach (dbFetchRows("SELECT entity_id FROM `entity_permissions` WHERE `entity_type` = 'bill' AND `user_id`= ? ORDER BY `entity_id`", array($value)) as $bill)
          {
            if ($first)
            {
              $where  .= "`entity_id` = ?";
              $first   = false;
            } else {
              $where  .= " OR `entity_id` = ?";
            }
            $param[]   = $bill['entity_id'];
          }
          $where      .= ")";
          break;
      }
    }
  }
}

// EOF
