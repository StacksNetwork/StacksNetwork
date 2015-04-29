var HBOperator  = {
    chats: {},
    lang: [],
    original_title: '',
    visitor_loop: undefined,
    status_loop: undefined,
    options: {
        debug: 0,
        sound: 1,
        blink_interval:800, //unread tab blink interval
        visitors_interval: 3000, //how often look for new visitors, chats, messages?,
        myinfo_interval: 20000, //how often ask about me?
        opentab_interval: 20000 //refresh current opened tab
    },
    visitors: 0,
    hostbill_url:'',
    myname:'You',
    current_status: 'Active',
    parseReponse:function(json) {
        if(typeof(json)=='undefined' || !json)
            return;
        if(json.errors) {
            for(var i in json.errors) {
                this.addError(json.errors[i]);
            }
        }
        if(json.infos) {
            for(var i in json.infos) {
                this.addInfo(json.infos[i],true);
            }
        }
    },
    getRand:function() {
            var date = new Date() ;
            return date.getTime() ;
    },
    addError: function (msg,flash) {
        var stick=typeof(flash)=='undefined'?true:false;
        $('#jGrowl').jGrowl(msg,{
            header:'Error',
            sticky: stick
        });

    },
    pickedTab: function() {
        var i= $('.hb_chat_tab:visible').attr('id');
        if(!i)
            return false;
        i= i.split('_');
        if(i.length<2)
            return false;
        return i;
    },
    chatWindowEvents: function(chat_id) {
        if(!$('#chat_'+chat_id).length)
            return false;
        var self = this;
         $('.c_inputbar textarea','#chat_'+chat_id).keyup(function(event){
             if(!event.shiftKey && (event.keyCode==13 || event.keyCode==10)) {
                 self.sendMSG();
             }
         });
         $('.sendbtn','#chat_'+chat_id).click(function(){
             self.sendMSG();
         });
    },
    sendMSG: function() {
        var c= this.pickedTab();
        if(!c || c[0]!='chat')
            return false;
        var chat = this.chats[c[1]];
        if(!chat || chat.status=='Closed' || chat.status=='Timeout' || chat.status=='Pending' )
            return false;

        var msg = $('.c_inputbar textarea','#chat_'+c[1]).val();
        if(msg=='' || msg==' ')
            return false;

        this.distribute_messages([{
            type:'Staff',
            chat_id:c[1],
            submitter_name:this.myname,
            message:msg
        }]);
        $('.c_inputbar textarea','#chat_'+c[1]).val('').focus();
        //send it
        $.post('?cmd=hbchat&action=message',{message:msg,chat_id:c[1]},function(){

        },'json').error(function(){});
    },
    addInfo: function (msg,flash) {
        var stick=typeof(flash)=='undefined'?true:false;
        $('#jGrowl').jGrowl(msg,{
            header:'Note',
            sticky: stick
        });

    },
    popupTranscription: function(chat_id) {
        var url="?cmd=hbchat&action=transcript&chat_id="+chat_id;
        window.open( url, "HBChat_Transcript", "scrollbars=yes,menubar=no,resizable=1,location=no,width=650,height=450,status=0" ) ;
        return false;
    },
    popupPrint: function(chat_id) {
        var url="?cmd=hbchat&action=print&chat_id="+chat_id;
        window.open( url, "HBChat_Print", "scrollbars=yes,menubar=no,resizable=1,location=no,width=650,height=450,status=0" ) ;
        return false;
    },
    debug_msg: function(msg) {
        if(this.options.debug)
            console.log(msg);
    },
    useCanned: function(el) {
        //get open tab
        var c= this.pickedTab();
        if(!c || c[0]!='chat')
            return false;
        if(!$(el).attr('content'))
            return false;
        
        this.switch_tab_bottom(c[1],'c_inputbar');
        var t = $('.c_inputbar textarea',"#chat_"+c[1]);
        var txt=t.val()+""+$(el).attr('content');
        t.val(txt).focus();
        return false;
        
    },
    switch_tab_bottom: function(chat_id,target) {
        $('.bottom_tabs_container .chat_tab_btm','#chat_'+chat_id).removeClass('chat_btm_active');
        $('.t'+target,'#chat_'+chat_id).addClass('chat_btm_active');

        $('.c_inputbar','#chat_'+chat_id+' .bottom_tabs_content').hide();
        $('.c_canned_content','#chat_'+chat_id+' .bottom_tabs_content').hide();
        $('.'+target,'#chat_'+chat_id+' .bottom_tabs_content').show();
        if(target=='c_canned_content' &&  !$('.'+target,'#chat_'+chat_id+' .bottom_tabs_content').hasClass('loaded')) {
            $('.'+target,'#chat_'+chat_id+' .bottom_tabs_content').addClass('loaded').html(this.renderTemplate('hb_chat_canned_fav',{}));
        }



        return false;
    },
    open_ticket: function (chat_id) {
        var self = this;
        if(self.chats[chat_id] && self.chats[chat_id].status!='Pending') {
            $.getJSON('?cmd=hbchat&action=openticket',{chat_id:chat_id},function(data){
                if(data) {
                    self.parseReponse(data);
                    if(data && data.success) {
                        self.update_visitors();
                    }
                }
            });
        }
    },
    populate_transcript: function(visitor_id,target) {
        var self=this;
        $.getJSON('?cmd=hbchat&action=visitortranscripts',{visitor_id:visitor_id},function(data){
            if(data && data.success) {
                var r=self.renderTemplate('hb_chat_transcripts', {transcripts:data.transcripts});
                target.html(r);
            }
        });
    },
    open_tab:function (type,id,content,switchafter,refresh, partialref) {
        var ref=false;
        if(typeof(refresh)!='undefined' && refresh)
            ref= true;
        var name,t="";
        var self = this;
        partialref = partialref || false;
        
        if(!ref && $('#'+type+'_tab_'+id).length) {
            $('#'+type+'_tab_'+id).click();
            return false;

        }
        
        switch(type) {
            case 'chat':
                if(!content) {
                    //fetch chat data
                    $.getJSON('?cmd=hbchat&action=chatdata',{
                        id:id,r:self.getRand()
                    },function(data){
                        self.parseReponse(data);
                        if(data && data.success) {
                            self.open_tab(type,id,data.chat,switchafter,refresh, partialref);
                        } else {
                            self.addError('Error fetching chat data');
                        }
                    });
                } else {
                    self.chats[id]={
                        id:id,
                        status:content.status,
                        visitor_name:content.visitor_name,
                        visitor_email:content.visitor_email
                    }
                    if(content.status=='Pending' || content.status=='Transfer') {
                        self.playSound('newchat');
                    }
                     name=content && typeof(content.visitor_name)!='undefined'?content.visitor_name:'unknown';
                    t = HBOperator.renderTemplate('hb_chat_tab_element_template', {
                        id:id,
                        type:type,
                        name:name
                    });
                    content.type=type;
                    if(ref) {
                        var current = $('.visitor_tabs li.current', '#chat_'+id).index(),
                        chatcontent = this.renderTemplate('hb_chat_tab_template', content);
                        $('#chat_tab_'+id).replaceWith(t);
                        if(partialref){
                            $('#chat_'+id+' > table > tbody > tr > td:last')
                            .html($(chatcontent).find('> table > tbody > tr > td:last').html());
                        }else
                            $('#chat_'+id).replaceWith(chatcontent);

                        $('.visitor_tabs li', '#chat_'+id).eq(current).click();
                    } else {
                        $('#hb_chat_tabs_container #clearer').before(t);
                        $('#hb_chat_tabs').append(this.renderTemplate('hb_chat_tab_template', content));

                    }
                   
                    self.chatWindowEvents(id);
                    if(content.messages && !partialref) {
                        self.distribute_messages(content.messages,true);
                    }
                    if(content.status=='Pending') {
                        $('.accept_call','#chat_'+id).show();
                    }
                    self.populate_transcript(content.visitor_id,$('.tab_transcripts','#chat_'+id));
                }
               
                break;
            case 'visitor':
                if(!content) {
                    //fetch his details
                    $.getJSON('?cmd=hbchat&action=visitordata',{
                        id:id,r:self.getRand()
                    },function(data){
                        self.parseReponse(data);
                        if(data && data.success) {
                            self.open_tab(type,id,data.visitor,switchafter,refresh, partialref);
                        } else {
                            self.addError('Error fetching visitor data');
                        }
                    });
                    return false;
                }
                name=typeof(content.name)!='undefined' && content.name!=''?content.name:'#'+id;
                name =(lang['Visitor']?lang['Visitor']:'') + ' '+name;
                t = HBOperator.renderTemplate('hb_chat_tab_element_template', {
                    id:id,
                    type:type,
                    name:name
                });
                if(ref) {
                    var current = $('.visitor_tabs li.current', '#visitor_'+id).index();
                    $('#visitor_tab_'+id).replaceWith(t);
                    $('#visitor_'+id).replaceWith(this.renderTemplate('visitor_details_template', content));
                    $('.visitor_tabs li', '#visitor_'+id).eq(current).click();
                } else {
                    $('#hb_chat_tabs_container #clearer').before(t);
                    $('#hb_chat_tabs').append(this.renderTemplate('visitor_details_template', content));
                }

                self.populate_transcript(id,$('.tab_transcripts','#visitor_'+id));
                break;
            default:
                return false;
                break;
        }
        if(switchafter) {
            $('#hb_chat_tabs_container .chat_tab:last').click();
        }else if(partialref){
            $(type == 'chat' ? '#chat_tab_'+id : '#visitor_tab_'+id).click();
        }

        if(!ref){
            self.update_open_tab(true);
        }
        return true;

    },
    inviteVisitor: function(visitor_id) {
        var msg = $('#invitation_message_'+visitor_id).val();
        var dept_id = $('#department_id_'+visitor_id).val();
        var self = this;
         $.getJSON('?cmd=hbchat&action=invite',{
            visitor_id:visitor_id,
            message:msg,
            department_id:dept_id,
            r:self.getRand()
        },function(data){
            self.parseReponse(data);
            if(data && data.success) {
                $('#invitation_container_'+visitor_id).hide();
                $('#invitation_message_'+visitor_id).val('');
            }
            
        }).error(function(){
            self.addError("AJAX Communication error");
        });
        
    },
    switch_visitor_tab: function(chat_id,target,el) {
        $('.visitor_tabs li','#'+chat_id).removeClass('current');
        $(el).addClass('current');
        $('.visitor_tabs_content .visitor_tab','#'+chat_id).hide();
        $('.visitor_tabs_content .tab_'+target,'#'+chat_id).show();
        switch(target) {
            case 'footprint':
                break;
            case 'visitor':
                break;
            case 'transcriptions':
                break;
            case 'geolocation':
                var l = $('.visitor_tabs_content .tab_'+target,'#'+chat_id);
                if(l.attr('loaded')!='1') {
                    l.attr('loaded','1');
                    this.gMaps(l);
                }
                break;
        }
        return false;
    },
    switch_tab: function(target,el) {
        if(!$('#'+target).length)
            return false;
        $('#hb_chat_tabs_container .chat_tab').removeClass('chat_tab_active');
        $(el).addClass('chat_tab_active').removeClass('blinking').removeClass('blink_on');
        document.title=this.original_title;
        $('#hb_chat_tabs .hb_chat_tab').hide();
        $('#'+target).show();
        this.muteSound();
        return false;
    },
    acceptChat:function(id) {
        var self=this;
        $.post('?cmd=hbchat&action=accept',{chat_id:id},function(data){
            self.parseReponse(data);
            if(data && data.success) {
                 $('.accept_call','#chat_'+id).hide();
                 self.chats[id].status='Active';
            }
        },'json');
        return false;
    },
    declineChat: function(id) {
        var self=this;
        if(self.chats[id])
            delete self.chats[id];
         $.post('?cmd=hbchat&action=reject',{chat_id:id},function(data){
            self.parseReponse(data);
        },'json');
        return false;
    },
    close_tab: function(target,auto) {
        if(!$('#'+target).length)
            return false;
            var self = this;
        $('#hb_chat_tabs_container .chat_tab').removeClass('chat_tab_active');
        var w = target.split('_');
        switch(w[0]) {
            case 'chat':
                $('#hb_chat_tabs_container #chat_tab_'+w[1]).remove();
                //close chat!
                if(self.chats[w[1]].status!='Pending') {
                    $.getJSON('?cmd=hbchat&action=closechat',{id:w[1],r:self.getRand()},function(data){
                        delete self.chats[w[1]];
                    });
                } else if(!auto) {
                    //decline
                    self.declineChat(w[1]);
                }
                break;
            case 'visitor':
                $('#hb_chat_tabs_container #visitor_tab_'+w[1]).remove();
                break;
        }
        $('#'+target).remove();
        $('#hb_chat_tabs_container .chat_tab:last').click();
        return false;
    },
    banVisitorPrompt: function(name,id) {
        this.open_modal(this.renderTemplate('visitorban_title', {visitor_name:name}),this.renderTemplate('visitorban_content', {visitor_name:name,id:id}));
        return false;
    },
    banVisitor: function(id) {
       this.close_modal();
       var self= this;
       $.post('?cmd=hbchat&action=banvisitor',{id:id},function(data){self.parseReponse(data);if(data && data.success) {
               self.addInfo('Selected user has been banned from future chats',true);
       }},'json');
    },
    update_chat_details: function () {

       this.close_modal();
       var chat_id= this.pickedTab();
       if(chat_id[0]!='chat')
           return false;
       var self= this;
       var vname=$('#osx-modal-data .visitor_name').val();
       var vemail = $('#osx-modal-data .visitor_email').val();
       $.post('?cmd=hbchat&action=updatechat',{chat_id:chat_id[1],visitor_name:vname,visitor_email:vemail},function(data){
           if(data && data.success) {
               self.open_tab('chat', chat_id[1], false, true, true);
           }
       },'json');
       return false;
    },
    user_change_prompt:function(chat_id) {
        var self=this;
        self.open_modal($('#visitorchange_title'),$('#visitorchange_notice'));

        $('#osx-modal-data input.visitor_name').val(self.chats[chat_id].visitor_name);
        $('#osx-modal-data input.visitor_email').val(self.chats[chat_id].visitor_email);
        return false;
    },
    close_modal: function() {
        $.modal.close();
        return false;
    },
    open_modal: function(title,content,onclose) {
        var f = OSX.close;
        var self = this;
        if(typeof(onclose)=='function') {
            f = function (d) {
                onclose.apply(this,arguments);
                self.close_modal();
            };
        }

        if(typeof(title)=='string')
            $('#osx-modal-title').html(title);
        else
            $('#osx-modal-title').html($(title).html());

        if(typeof(content)=='string')
            $('#osx-modal-data').html(content);
        else
            $('#osx-modal-data').html($(content).html());

        $("#osx-modal-content").modal({
            overlayId: 'osx-overlay',
            containerId: 'osx-container',
            closeHTML: null,
            minHeight: 80,
            opacity: 65,
            position: ['0',],
            overlayClose: true,
            onOpen: OSX.open,
            onClose: f
        });
    },
    //Init chat - start loops, init DOM objects
    init: function() {
        this.bindEvents();
        this.update_visitors(true);
        this.initSounds();
        this.update_my_info();
        this.blinkLoop();
        this.original_title=document.title;
    },

    blinkLoop: function() {
       var self=HBOperator;
        if($('.blinking','#hb_chat_tabs_container').toggleClass('blink_on').length) {
            if(document.title.indexOf('Alert') > -1) {
                document.title=self.original_title;
            } else {
                document.title="#! Alert !# "+self.original_title;
            }
        }
        setTimeout(self.blinkLoop,self.options.blink_interval);
    },

    bindEvents: function() {
        var self = this;
        window.onbeforeunload = function() {
            self.eventBeforeUnload();
            return "Are you sure?" ;
        }
        $(document).bind('keydown keyup', function(e){
            if(e.keyCode == 116){
                e.preventDefault();
                if(e.type == 'keydown'){
                   self.update_visitors(true);
                   self.update_open_tab();
                }
                return false;
            }
        });
    },
    eventBeforeUnload: function() {
        var p = this.current_status;
        var self= this;
        this.change_status('Offline-Signal');
        setTimeout(function(){
            self.change_status(p);
        },120);
    },
    set_status_remote: function(status,callback) {
        var self= this;
        if(status!=this.current_status) {
            var c = function(){};
            if(typeof(callback)=='function') {
                c=function(){
                    callback.apply(this,arguments);
                };
            }
            $.getJSON('?cmd=hbchat&action=status',{
                status:status,
                r:self.getRand()
            },function(data){
                if(data && data.success) {
                    c.apply(this,arguments);
                }
            }).error(function(){
            self.addError("AJAX Communication error",true);
        });
            this.current_status=status;
            return true;
        }
        return false;
    },
    //change my status - popups, timeouts etc
    change_status: function(status) {
        var self = this;
        if(status!=this.current_status) {
            switch(status) {
                case 'Offline':
                    this.open_modal($('#offline_notice_title'),$('#offline_notice'),function(){
                        HBOperator.change_status('Active')
                    });
                    return false;
                    break;
                case 'Offline-Signal':
                    $('input[name=current_status]').removeAttr('checked');
                    $('#status_offline').attr('checked','checked');
                    this.set_status_remote('Offline');
                    status='Offline';
                    break;
                case 'Offline-Confirmed':
                    //ajax
                    $('input[name=current_status]').removeAttr('checked');
                    $('#status_offline').attr('checked','checked');
                    this.set_status_remote('Offline', function(){
                        window.onbeforeunload = null ;
                        window.close();
                    });
                    return false;
                    break;
                case 'Away':
                    //ajax
                    this.open_modal($('#away_notice_title'),$('#away_notice'),function(){
                        HBOperator.change_status('Active')
                    });
                    this.set_status_remote('Away');
                    break;
                case 'Active':
                    //ajax
                    $('input[name=current_status]').removeAttr('checked');
                    $('#status_active').attr('checked','checked');
                    this.set_status_remote('Active');
                    break;
            }

            return true;
        }
        return false;
    },
    //template functions
    renderTemplate: function(tpl_id, data, target) {
        if(!$('#'+tpl_id,'#hb_chat_template').length) {
            return false;
        }
        var h  = Mustache.to_html($('#'+tpl_id,'#hb_chat_template').val(),data);
        if(typeof(target)!='undefined' && $('#'+target).length)
            $('#'+target).html(h);
        return h;
    },

    //get my current status, my chat statistics
    update_my_info: function() {
        var self=HBOperator;
        if (self.status=='Offline') {
            return;
        }
        $.getJSON('?cmd=hbchat&action=update_my_info',{r:self.getRand()},function(data){
            if(data && data.success) {
                $('#chats_today_cnt').text(data.myinfo.chats_today);
            } else {
                self.addError('Error updating staff status, re-connecting',true);
            }

            setTimeout(self.update_my_info,self.options.myinfo_interval);
        }).error(function(){
            self.addError("AJAX Communication error, re-connecting",true);
            setTimeout(self.update_my_info,self.options.myinfo_interval);
        });
    }, prepareMSG: function(string) {
        if ( string.substr((string.length-2), string.length) == "\r\n" ) {string=string.substr(0, (string.length-2)) ;}
	else if ( string.substr((string.length-1), string.length) == "\n" ) {string= string.substr(0, (string.length-1)) ;}

        string= string.replace(/>/g, "&gt;");
        string= string.replace(/</g, "&lt;");

        var replacePattern1 = /(\b(https?|ftp):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/gim;
        string = string.replace(replacePattern1, '<a href="$1" target="_blank">$1</a>');

        var replacePattern2 = /(^|[^\/])(www\.[\S]+(\b|$))/gim;
        string=string.replace(replacePattern2, '$1<a href="http://$2" target="_blank">$2</a>');

        var replacePattern3 = /(\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,6})/gim;
        string = string.replace(replacePattern3, '<a href="mailto:$1">$1</a>');
        //nl2br
        return string.replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1<br/>$2');
    },
    distribute_messages:function(data,nosound) {
        for(var i in data) {
            if(!this.chats[data[i].chat_id] || !$('#chat_'+data[i].chat_id).length)
                continue;
            if(data[i].message)
                data[i].message = this.prepareMSG(data[i].message);
            var m = this.renderTemplate('message_template',data[i]);
            $('.conversation_content div.messages','#chat_'+data[i].chat_id).append(m);
            $(".conversation_content",'#chat_'+data[i].chat_id).scrollTop($(".conversation_content div.messages",'#chat_'+data[i].chat_id)[0].scrollHeight);
            if(!$('#chat_tab_'+data[i].chat_id).hasClass('chat_tab_active')) {
                //blink and sound!
                if(!nosound){
                   this.playSound('newmsg');
                }
                $('#chat_tab_'+data[i].chat_id).addClass('blinking');
            }
        }
    },
    update_chats: function(data) {
        if(!data)
            return;
        for(var i in data) {
            if(!this.chats[i] && data[i].status!='Closed' && data[i].status!='Timeout') {
                //new chat, popup!
                this.open_tab('chat', i);
                continue;
            }
            if(this.chats[i] && data[i].status!=this.chats[i].status) {
                if(this.chats[i].status=='Pending' && (data[i].status=='Timeout' || data[i].status=='Closed')) {
                    this.close_tab('chat_'+i, true);
                    delete this.chats[i];
                } else {
                    this.chats[i].status=data[i].status;

                }

            }
        }
        for(var i in this.chats) {
            if(!data[i]) {
                //timeout chat request
                    delete this.chats[i];
            }
        }
    },
    //get visitors online, refresh visitors table, play sound if required, set loop
    update_visitors: function(detx) {
        clearTimeout(HBOperator.visitor_loop);
        HBOperator.visitor_loop=undefined;
        var det = typeof(detx)=='boolean'?1:0;
        var self=HBOperator;
        if (self.status=='Offline') {
            return;
        }
        $.post('?cmd=hbchat&action=pull',{
            details:det,chats:self.chats,r:self.getRand()
        },function(data){
             self.parseReponse(data);
            if(data && data.success) {
                if(data.pulldata.chats)
                    self.update_chats(data.pulldata.chats);
                if(data.pulldata.messages)
                    self.distribute_messages(data.pulldata.messages);
                if(data.visitors_count!=self.visitors) {
                    self.playSound('visitorchange');
                    self.visitors = data.visitors_count;
                    $('#visitors_count').text(self.visitors);
                    if(!det) {
                        //refresh table!
                        self.update_visitors(true);
                        return;
                    }
                }
                if(det)
                    self.refresh_visitors_table(data);

            } else {
                self.addError('Error fetching visitors online, re-connecting',true);
            }
            HBOperator.visitor_loop=setTimeout("HBOperator.update_visitors()",HBOperator.options.visitors_interval);

        },'json').error(function(){
            self.addError("AJAX Communication error, re-connecting",true);
            HBOperator.visitor_loop=setTimeout("HBOperator.update_visitors()",HBOperator.options.visitors_interval);
        });
    },
    update_open_tab_loop: false,
    update_open_tab: function(init){
        var initial = typeof(init)=='boolean'?1:0;
        var self=HBOperator;
        if (self.status=='Offline') {
            return;
        }
        if(!initial){
            $('.chat_tab_active').each(function(){
                if(!$(this).attr('id'))
                    return;
                var type = $(this).hasClass('tchat') ? 'chat' : 'visitor';
                HBOperator.open_tab(type, $(this).attr('id').replace(/[^\d]*/g,''), false, false, true, true);
            });
        }
            
        clearTimeout(HBOperator.update_open_tab_loop);
        HBOperator.update_open_tab_loop=setTimeout("HBOperator.update_open_tab()",HBOperator.options.opentab_interval);
    },
    
    refresh_visitors_table: function(data) {
        this.renderTemplate('hb_visitors_table_template',data,'hb_traffic_table');
    },

   
    //SOUNDS:
    sound_visitorchange:false,
    sound_newchat:false,
    sound_newmsg:false,
    sound_swfpath:false,
    sounds:[],

    initSounds: function() {
        var self = this;
        self.options.sound=false;
        soundManager.onready(function() {
            soundManager.createSound({
              id:'visitorchange',
              url:self.sound_visitorchange
            });
           soundManager.createSound({
              id:'newchat',
              url:self.sound_newchat
            });
         soundManager.createSound({
              id:'newmsg',
              url:self.sound_newmsg
            });
        self.options.sound=true;
        });
    },
    muteSound: function() {
        var s = soundManager.getSoundById('newchat');
        for(var i in this.chats) {
            if(this.chats[i].status=='Pending') {
                if($('#chat_tab_'+i).hasClass('blinking'))
                    return;
            }
        }
        s.stop();
    },
    playSound: function(which) {
        if(this.options.sound) {
            var s = soundManager.getSoundById(which);
            if(s.playState)
                s.stop();
            if(which=='newchat') {
                s.play({loops:10});
            }else {
                s.play();
            }
        }
    },
    printChat: function(chat_id) {
        var url="?cmd=hbchat&action=transcript&chat_id="+chat_id;
        window.open( url, "HBChat_Print", "scrollbars=yes,menubar=no,resizable=1,location=no,width=650,height=450,status=0" ) ;
        return false;
    },
    toggleChatSound: function() {
        if(this.options.sound==1) {
            this.options.sound=0;
            $('.chat_sound_icon').removeClass('sound_on');
        } else {
            this.options.sound=1;
            $('.chat_sound_icon').addClass('sound_on');
        }
    },
    gMaps: function(domElement) {
        var longitude=domElement.attr('longitude');
        var latitude=domElement.attr('latitude');
        if(!longitude && !latitude)
            return false;
        $.getScript("https://maps.googleapis.com/maps/api/js?sensor=false&region=nz&async=2&callback=MapApiLoaded", function () {});
    }


};

function MapApiLoaded() {
        var l=$('.tab_geolocation','.hb_chat_tab:visible');
        if(!l.length)
            return;

        var longitude=parseFloat(l.attr('longitude'));
        var latitude=parseFloat(l.attr('latitude'));
        
            var centerCoord = new google.maps.LatLng(latitude, longitude);
            var mapOptions = {
                zoom: 5,
                center: centerCoord,
                disableDefaultUI: true,
                panControl: true,
                zoomControl: true,
                scaleControl:true,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            var map = new google.maps.Map(l.get(0), mapOptions);
            new google.maps.Marker({
                position: new google.maps.LatLng(latitude,longitude),
                map: map
            });
}