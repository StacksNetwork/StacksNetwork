<script src="{$tplurl}js/prettyprint/prettify.js"></script>
<link media="all" type="text/css" rel="stylesheet" href="{$tplurl}js/prettyprint/css.css" />
<h2>Choose export method from available below:</h2>
<div class="accordion" id="accordion2">
    <div class="accordion-group">
        <div class="accordion-heading">
            <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseOne">
                <i class="icon-th-list"></i> <b>Get code to place on website</b>
            </a>
        </div>
        <div id="collapseOne" class="accordion-body collapse in">
            <div class="accordion-inner">
                <div class="row">
                    <div class="span4">
                        If you have access to full page source, use this option to embed slider code.
                    </div>
                    <div class="span8">
                        <h4>Place code below between &lt;head&gt;&lt;/head&gt; tags of your website</h4>
                        <pre class="prettyprint">{$slider.head|htmlspecialchars}</pre>
                        <h4>Put code below in place where your slides should appear</h4>
                        <pre class="prettyprint">{$slider.body|htmlspecialchars}</pre>
                        <h4>Place code below before &lt;/body&gt; tag</h4>
                        <pre class="prettyprint">{$slider.end|htmlspecialchars}</pre>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="accordion-group">
        <div class="accordion-heading">
            <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseTwo">
                <i class="icon-film"></i> <b>Get code to place in wordpress post</b>
            </a>
        </div>
        <div id="collapseTwo" class="accordion-body collapse">
            <div class="accordion-inner">
                <div class="row">
                    <div class="span4">
                        If you just want to put slider in your blog post/page, without editing additional files, just paste this code in HTML source of your post
                    </div>
                    <div class="span8">
                        <pre class="prettyprint">{$slider.head|htmlspecialchars}
{$slider.body|htmlspecialchars}
{$slider.end|htmlspecialchars}</pre>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="accordion-group">
        <div class="accordion-heading">
            <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseThree">
                <i class="icon-arrow-down"></i> <b>Download zip archive</b>
            </a>
        </div>
        <div id="collapseThree" class="accordion-body collapse">
            <div class="accordion-inner">
                <div class="row">
                    <div class="span4">
                        If you want to use your slider locally, and serve slides and code from server other than your HostBill use this option.
                    </div>
                    <div class="span8">
                        <a class="btn btn-primary btn-large" href="?cmd=hbslider&action=zip&id={$slider.id}" style="color:white">Download ZIP</a>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <div class="accordion-group">
        <div class="accordion-heading">
            <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseFour">
                <i class="icon-shopping-cart"></i>  <b>Use it as orderpage</b>
            </a>
        </div>
        <div id="collapseFour" class="accordion-body collapse">
            <div class="accordion-inner">
                <div class="row">
                    <div class="span12">
                        To use this slider as an orderpage go to <b>Settings->Products &amp; Services</b> and pick <b>"Slideshow based on Slider plugin"</b> orderpage, click on <b>Customize</b> and select your slider.
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
{literal}
<script>
        !function ($) {
        $(function(){
            // make code pretty
            window.prettyPrint && prettyPrint()
        })
    }(window.jQuery)
</script>
{/literal}