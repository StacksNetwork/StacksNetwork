
<ul class="im-dashboard clear">
    <li>
        <a href="?cmd=inventory_manager&action=deliveries" onclick="return showFacebox('?cmd=inventory_manager&amp;action=newdelivery')" class="fa-icon">
            <i class="fa fa-truck fa-5x"></i>
            <span>添加新的设备采购</span>
        </a>
    </li>
    <li>
        <a href="#search" class="fa-icon" data-content="search" data-grid="itemsearch">
            <i class="fa fa-search fa-5x"></i>
            <span>闲置配件/备件搜索</span>
        </a>
    </li>
    <li>
        <a href="#" class="fa-icon" data-grid="lowqty" >
            <i class="fa fa-exclamation fa-5x"></i>
            <span>配件/备件缺货警报</span>
        </a>
        <div class="after"></div>
    </li>
    <li>
        <a href="#" class="fa-icon" data-grid="guarantee" >
            <i class="fa fa-wrench fa-5x "></i>
            <span>过保修期的设备</span>
        </a>
    </li>
    <li>
        <a href="#" class="fa-icon" data-grid="support" >
            <i class="fa fa-stethoscope fa-5x"></i>
            <span>过售后服务期的设备</span>
        </a>
    </li>
    <li>
        <a href="#" class="fa-icon" data-grid="builds" >
            <i class="fa fa-spinner fa-5x"></i>
            <span>正在调试配置中的设备</span>
        </a>
    </li>
</ul>
<div id="cnt_search" class="subcontent" style="display: none;">
    <p>输入配件序列号: <input type="text" name="sn" id="itemsearch" onkeyup="return searchItems(this, event);"></p>
</div>
{literal}
    <style>
        .im-dashboard{
            padding: 0;margin: 0 -11px;
        }
        .im-dashboard li.content{
            display: block;
            width: auto;
            background: #585858;
            min-height: 10px;
            box-shadow: 0 1px 3px inset;
            padding: 15px 10px;
            overflow: hidden;
        }
        .im-dashboard li .subcontent{
            text-shadow: 0 1px black;
            color:white;
            text-align: left;
            padding: 1px 0;
        }
        .im-dashboard li {
            display: inline-block;
            text-align: center;
            width: 33%;
            padding: 20px 0;
        }
        .im-dashboard li.active{
            position:relative;
        }
        .im-dashboard li.active::before, .im-dashboard li.active::after {
            content: '_';
            font-size: 0;
            color:#575757; 
            display: block;
            width: 0px;
            height: 0px;
            position: absolute;
            left:50%;
            bottom: 0;
            margin-left: -10px;
            margin-bottom: -4px;
            border: 10px solid transparent;
            border-bottom-color: #575757; 
            z-index: 10;
        }
        .im-dashboard li.active::before{
            border-bottom-color: #353535;
            margin-bottom: -2px;
            margin-left: -10px;
            width: 0;
        }
        .im-dashboard li a.fa-icon{
            text-decoration: none;
            color:#474747;
        }
        .im-dashboard li a.fa-icon span{
            display: block;
            font-size: 18px;
            font-weight: bold;
        }
    </style>
    <script type="text/javascript">

            function toggleContent(el) {
                var link = $(el),
                        that = link.parent(),
                        top = that.position().top,
                        cnt = $('.im-dashboard li.content');

                if (cnt.length && that.hasClass('active')) {
                    cnt.slideUp('fast', function() {
                        $('.im-dashboard .active').removeClass('active');
                        cnt.remove();
                    });
                } else {
                    var after = that;
                    that.nextAll().each(function(i) {
                        if (top < $(this).position().top) {
                            after = $(this).prev();
                            return false;
                        } else if (i == that.nextAll().length - 1) {
                            after = $(this);
                        }
                    });

                    if (!cnt.length)
                        cnt = $('<li class="content"></li>').hide()
                    if ($('.im-dashboard .active').length && $('.im-dashboard .active').position().top == after.position().top)
                        cnt.detach();

                    cnt.slideUp(function() {
                        cnt.detach();
                        cnt.insertAfter(after);
                        $('.im-dashboard .active').removeClass('active');
                        that.addClass('active');
                        cnt.html('');
                        var grid = false;
                        cnt.slideDown({
                            start: function() {
                                var usedh = 0;
                                if (link.attr('data-content')) {
                                    if(!link.data('data-content')){
                                        link.data('data-content', $('#cnt_'+link.attr('data-content')).detach());
                                    }
                                    usedh = $(link.data('data-content')).appendTo(cnt).show().outerHeight(true);
                                }
                                if (link.attr('data-grid') && GridTemplates[link.attr('data-grid')]) {
                                    var template = GridTemplates[link.attr('data-grid')];
                                    do {
                                        var id = Math.round(Math.random() * 1000);
                                    } while ($('#list' + id).length);
                                    $(cnt).append('<table id="list' + id + '"></table><div id="pager' + id + '"></div>');
                                    grid = $('#list' + id).jqGrid($.extend(template.grid,{
                                        height:200-usedh,
                                        rowNum: 10,
                                        pager: '#pager' + id
                                    }));
                                    var fn = grid.jqGrid("getGridParam", "gridComplete");
                                    grid.jqGrid("setGridParam", {
                                        gridComplete: function(rowid, status) {
                                            if (typeof fn == 'function')
                                                fn.apply(this);
                                            highlight.apply(this);
                                            grid.jqGrid('setGridWidth', $(cnt).width());
                                        }
                                    });
                                    grid.jqGrid.apply(grid, ['navGrid', '#pager' + id, ].concat(template.nav));
                                }
                            },
                            stop: function(){
                                grid.jqGrid('setGridWidth', $(cnt).width());
                            }
                        });
                    })
                }
            }
            var SnSearch = {
                Timeout:false,
                requestString:''
            };

            function searchItems(that, event){
                var search = function(){
                    if($.active){
                        clearTimeout(SnSearch.Timeout);
                        SnSearch.Timeout = setTimeout(search,500);
                        return false;
                    }
                    
                    var input = $(that),
                        grid = input.parents('.content').find('table');
                    if(SnSearch.requestString != input.val() || event.keyCode == 13){
                        SnSearch.requestString = input.val();
                        grid.trigger('reloadGrid');
                    }
                }
                search();
            }
            $('.im-dashboard li a[data-grid]').click(function() {
                toggleContent(this);
                return false;
            })
    </script>
{/literal}