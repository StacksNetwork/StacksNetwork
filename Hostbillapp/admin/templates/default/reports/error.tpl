{literal}<style>
        #error {
        margin:10px;background:#F2DEDE;border-radius:4px;border:solid 1px #EED3D7;color:#B94A48;
        font-size:13px;font-family:"Helvetica Neue",Helvetica,Arial,sans-serif;line-height:18px;
        padding:14px;text-shadow:0 1px 0 rgba(255, 255, 255, 0.5);
        }</style>{/literal}
        <div id="error">
{foreach from=$error item=blad}
<b> {$blad} </b> <br/>
{/foreach}
  </div>