
{literal}
<style>
    #hbs-demo .hbs-container {
        margin:40px auto;
    }</style>
     <script>
        $(document).ready(function(){
            $('#slider').hbslider({
                effect: 'pixelate',
                random:true,
                style: 'plasma',
                captionstyle:'right-wide',
                slidedisplaytime: 6000
            });
        });

    </script>
    {/literal}
<script src="{$system_url}templates/slider/hbslider.min.js"></script>
<script src="{$system_url}templates/slider/effects/pixelate/pixelate.js"></script>
<link rel="stylesheet" href="{$system_url}templates/slider/defaults.css">
<link rel="stylesheet" href="{$system_url}templates/slider/styles/plasma/plasma.css">
<script src="{$system_url}templates/slider/styles/plasma/plasma.js"></script>
<div id="hbs-demo">

    <div id="slider">
        <div >
            <img src="{$system_url}templates/slider/demo/slide_1.jpg">
            <div class="hbs-caption">
                <h2>Create beautiful Content Sliders</h2>
                <p>Using this tool you can build custom jQuery sliders FAST, no programming skills required.</p>
                <ul>
                    <li>Upload images directly into slider builder</li>
                    <li>Provide captions, choose effects, set animation details</li>
                    <li>Provide captions, choose effects, set animation details</li>
                </ul>
                <p>Just think of possibilities!</p>
                <ul>
                    <li>Create beautiful feature pages for your products</li>
                    <li>Use slider as order page to attract more customers</li>
                    <li>Slide anything! Images, html content - you name it!</li>
                </ul>

                <p><a class="btn btn-primary btn-large" href="?cmd=hbslider&action=add" style="color:white; position:absolute; bottom:40px">Create your new slider</a></p>
            </div>
        </div>
        <div >
            <img src="{$system_url}templates/slider/demo/slide_2.jpg">
            <div class="hbs-caption">
                <h2>Easy to use, multipurpose</h2>
                <h4>No HTML knowledge required!</h4>
                <p>Just fill in a form and get code ready to be pasted on your website</p>
                <h4>No FTP uploads required!</h4>
                <p>Code & images will be hosted in your HostBill. You want to load them from your website locally? Not a problem, get a zip file with your slider, ready to be used on your website</p>
                <p><a class="btn btn-primary btn-large" href="?cmd=hbslider&action=add" style="color:white; position:absolute; bottom:40px">Create your new slider</a></p>
            </div>
        </div>
         <div >
            <img src="{$system_url}templates/slider/demo/slide_3.jpg">
            <div class="hbs-caption">
                <h2>Created with passion</h2>
                <p>We've spent hours creating easy to use custom effects and styles, so you don't have to! <br/> <b>HBSlider</b> is:</p>
                <ul>
                    <li>Easy to use</li>
                    <li>Easy to extend with new transition effects</li>
                    <li>Easy to customize with own css/js styles</li>
                </ul>
                <p><a class="btn btn-primary btn-large" href="?cmd=hbslider&action=add" style="color:white; position:absolute; bottom:40px">Create your new slider</a></p>
            </div>
        </div>
    </div>
</div>
