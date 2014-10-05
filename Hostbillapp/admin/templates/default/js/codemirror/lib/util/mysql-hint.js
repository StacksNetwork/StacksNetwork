(function () {
  function forEach(arr, f) {
    for (var i = 0, e = arr.length; i < e; ++i) f(arr[i]);
  }

  function arrayContains(arr, item) {
    if (!Array.prototype.indexOf) {
      var i = arr.length;
      while (i--) {
        if (arr[i] === item) {
          return true;
        }
      }
      return false;
    }
    return arr.indexOf(item) != -1;
  }

  function scriptHint(editor, keywords, getToken, options) {
    // Find the token at the cursor
    var cur = editor.getCursor(), token = getToken(editor, cur), tprop = token;
    // If it's not a 'word-style' token, ignore the token.
		if (!/^[\w$_]*$/.test(token.string)) {
      token = tprop = {start: cur.ch, end: cur.ch, string: "", state: token.state,
                       type: token.string == "." ? "property" : null};
    }
    // If it is a property, find out what it is a property of.
    while (tprop.type == "property") {
      tprop = getToken(editor, {line: cur.line, ch: tprop.start});
      if (tprop.string != ".") return;
      tprop = getToken(editor, {line: cur.line, ch: tprop.start});
      if (tprop.string == ')') {
        var level = 1;
        do {
          tprop = getToken(editor, {line: cur.line, ch: tprop.start});
          switch (tprop.string) {
          case ')':level++;break;
          case '(':level--;break;
          default:break;
          }
        } while (level > 0);
        tprop = getToken(editor, {line: cur.line, ch: tprop.start});
	if (tprop.type == 'variable')
	  tprop.type = 'function';
	else return; // no clue
      }
      if (!context) var context = [];
      context.push(tprop);
    }
    return {list: getCompletions(token, context, keywords, options),
            from: {line: cur.line, ch: token.start},
            to: {line: cur.line, ch: token.end}};
  }


  var all_tables = {};

      CodeMirror.mysqlHint = function(editor, options) {
        var table_names = [];
        if(typeof editor.options.hb_tables=='object') {
            all_tables = editor.options.hb_tables;
            for(var k in hb_tables)
                table_names.push(k);
        }
        return scriptHint(editor, table_names,
            function (e, cur) {
                return e.getTokenAt(cur);
            },
            options);
    };

 

  

  
 
  function getCompletions(token, context, keywords, options) {
    var found = [], start = token.string;
    function maybeAdd(str) {
      if (str.indexOf(start) == 0 && !arrayContains(found, str)) found.push(str);
    }
    function gatherCompletions(obj) {
      for (var name in obj) maybeAdd(name);
    }

    if (context) {
      var obj = context.pop(), base;
      if (obj.type == "variable") {
          base = "`"+obj.string+"`";
      } else if (obj.type == "variable-2") {
        base = obj.string;
      }
      if(base && typeof(all_tables[base])!='undefined') {
          forEach(all_tables[base], maybeAdd);
      }
     
    }
    else {
      // If not, just look in the window object and any local scope
      // (reading into JS mode internals to get at the local variables)
      for (var v = token.state.localVars; v; v = v.next) maybeAdd(v.name);
      forEach(keywords, maybeAdd);
    }
    return found;
  }
})();
