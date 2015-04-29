
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

    <script type="text/javascript" src="{$template_dir}js/jquery-1.3.2.min.js?v={$hb_version}"></script>
<script type="text/javascript">
var lang=[];
lang['edit']="{$lang.Edit}";
</script>
<script type="text/javascript" src="{$template_dir}js/packed.js?v={$hb_version}"></script>
<script type="text/javascript">Date.format = '{$js_date}';startDate='{$js_start}';</script>
<script type="text/javascript">var ts=new Date();var ss=ts.getMinutes();if(ss<10)ss="0"+ss;var s=ts.getHours().toString()+':'+ss;</script>
<link href="{$template_dir}_style.css" rel="stylesheet" media="all" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<body class="{$language}">

<div style="width:600px" id="facebox">{include file='ajax.configfields.tpl'}</div>
</body>
</html>