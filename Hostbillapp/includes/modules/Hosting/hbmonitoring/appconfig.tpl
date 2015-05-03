 <table border="0" cellpadding="6" cellspacing="0" width="100%" style="margin-bottom:10px;">
     <tr>
         <td></td>
         <td>提供您的远程监控节点的细节. 在新的节点HostBill创建单独的应用程序..</td>
     </tr>
       <tr><td  align="right" width="165"><strong>节点IP</strong></td><td ><input  name="ip" size="60" value="{$server.ip}" class="inp"/></td></tr>
       <tr><td  align="right" width="165"><strong>API用户</strong></td><td ><input  name="username" size="25" value="{$server.username}" class="inp"/></td></tr>
      <tr><td  align="right" width="165"><strong>API密码</strong></td><td ><input type="password" name="password" size="25" class="inp" value="{$server.password}" autocomplete="off"/></td></tr>
        
      
        <tr>
         <td></td>
         <td><b>创建新节点:</b></td>
     </tr> 
     <tr>
         <td></td>
         <td><div id="htacode" class="code" style=" margin: 5px 0px; -webkit-box-shadow: rgb(136, 136, 136) 0px 0px 2px inset; padding: 10px;">
#1. 创建VM x86_64全新安装CentOS 6.4 <br/>
#2. 以root身份登录, 发出命令: <br/>
# wget -O - http://install.hostbillapp.com/hbmonitoring/install.sh | /bin/bash <br/>
#3. 更新 /home/nodemonit/uptime/config/default.yaml  <b>监控</b> 部分设定的API用户, 密码和URL到HostBill <br/>
#4. 启动监控节点: /etc/init.d/hbmonitoring start <br/>
#5. 更新连接细节上面的API用户名/密码设置步骤3.
<br/><br/>
如果您使用CGI/PHP处理程序好向上/向下通知的过程, 请加在您的.htaccess文件HostBill: <br/>{literal}
&lt;IfModule mod_rewrite.c&gt;<br/>
     RewriteEngine on<br/>
     RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization},L]<br/>
&lt;/IfModule&gt; {/literal}
</div>
         </td>
     </tr>
    </table>
