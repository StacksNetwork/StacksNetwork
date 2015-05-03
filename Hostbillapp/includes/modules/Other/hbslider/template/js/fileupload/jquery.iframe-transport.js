/*
 * jQuery Iframe Transport Plugin 1.5
 * https://github.com/blueimp/jQuery-File-Upload
 *
 * Copyright 2011, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * http://www.opensource.org/licenses/MIT
 */

/*jslint unparam: true, nomen: true */
/*global define, window, document */
(function(e){"use strict";typeof define=="function"&&define.amd?define(["jquery"],e):e(window.jQuery)})(function(e){"use strict";var t=0;e.ajaxTransport("iframe",function(n){if(n.async&&(n.type==="POST"||n.type==="GET")){var r,i;return{send:function(s,o){r=e('<form style="display:none;"></form>'),r.attr("accept-charset",n.formAcceptCharset),i=e('<iframe src="javascript:false;" name="iframe-transport-'+(t+=1)+'"></iframe>').bind("load",function(){var t,s=e.isArray(n.paramName)?n.paramName:[n.paramName];i.unbind("load").bind("load",function(){var t;try{t=i.contents();if(!t.length||!t[0].firstChild)throw new Error}catch(n){t=undefined}o(200,"success",{iframe:t}),e('<iframe src="javascript:false;"></iframe>').appendTo(r),r.remove()}),r.prop("target",i.prop("name")).prop("action",n.url).prop("method",n.type),n.formData&&e.each(n.formData,function(t,n){e('<input type="hidden"/>').prop("name",n.name).val(n.value).appendTo(r)}),n.fileInput&&n.fileInput.length&&n.type==="POST"&&(t=n.fileInput.clone(),n.fileInput.after(function(e){return t[e]}),n.paramName&&n.fileInput.each(function(t){e(this).prop("name",s[t]||n.paramName)}),r.append(n.fileInput).prop("enctype","multipart/form-data").prop("encoding","multipart/form-data")),r.submit(),t&&t.length&&n.fileInput.each(function(n,r){var i=e(t[n]);e(r).prop("name",i.prop("name")),i.replaceWith(r)})}),r.append(i).appendTo(document.body)},abort:function(){i&&i.unbind("load").prop("src","javascript".concat(":false;")),r&&r.remove()}}}}),e.ajaxSetup({converters:{"iframe text":function(t){return e(t[0].body).text()},"iframe json":function(t){return e.parseJSON(e(t[0].body).text())},"iframe html":function(t){return e(t[0].body).html()},"iframe script":function(t){return e.globalEval(e(t[0].body).text())}}})})