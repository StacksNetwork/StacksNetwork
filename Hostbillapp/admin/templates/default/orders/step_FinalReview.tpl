{if $step.status=='Completed'}
  <span class="info-success">订单已审阅并设置为活动</span>

{else}
    订单等待人工审核. <br/><br/>
    <a class="menuitm greenbtn" href="?cmd=orders&action=executestep&step=FinalReview&order_id={$details.id}&security_token={$security_token}&skip=true" ><span>标记订单为激活状态</span></a> <span class="orspace">注意: 这个动作仅改变订单状态</span>


{/if}