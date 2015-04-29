var timing = 0;
var t = '';  //interval
var maximum = 10;
var num_errors = 0;
var num_infos = 0;
Date.dayNames = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
Date.abbrDayNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
Date.monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
Date.abbrMonthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
Date.firstDayOfWeek = 1;
Date.format = 'dd/mm/yyyy';
Date.fullYearStart = '20';
(function() {
    function add(name, method) {
        if (!Date.prototype[name]) {
            Date.prototype[name] = method
        }
    }
    ;
    add("isLeapYear", function() {
        var y = this.getFullYear();
        return(y % 4 == 0 && y % 100 != 0) || y % 400 == 0
    });
    add("isWeekend", function() {
        return this.getDay() == 0 || this.getDay() == 6
    });
    add("isWeekDay", function() {
        return!this.isWeekend()
    });
    add("getDaysInMonth", function() {
        return[31, (this.isLeapYear() ? 29 : 28), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][this.getMonth()]
    });
    add("getDayName", function(abbreviated) {
        return abbreviated ? Date.abbrDayNames[this.getDay()] : Date.dayNames[this.getDay()]
    });
    add("getMonthName", function(abbreviated) {
        return abbreviated ? Date.abbrMonthNames[this.getMonth()] : Date.monthNames[this.getMonth()]
    });
    add("getDayOfYear", function() {
        var tmpdtm = new Date("1/1/" + this.getFullYear());
        return Math.floor((this.getTime() - tmpdtm.getTime()) / 86400000)
    });
    add("getWeekOfYear", function() {
        return Math.ceil(this.getDayOfYear() / 7)
    });
    add("setDayOfYear", function(day) {
        this.setMonth(0);
        this.setDate(day);
        return this
    });
    add("addYears", function(num) {
        this.setFullYear(this.getFullYear() + num);
        return this
    });
    add("addMonths", function(num) {
        var tmpdtm = this.getDate();
        this.setMonth(this.getMonth() + num);
        if (tmpdtm > this.getDate())
            this.addDays(-this.getDate());
        return this
    });
    add("addDays", function(num) {
        this.setTime(this.getTime() + (num * 86400000));
        return this
    });
    add("addHours", function(num) {
        this.setHours(this.getHours() + num);
        return this
    });
    add("addMinutes", function(num) {
        this.setMinutes(this.getMinutes() + num);
        return this
    });
    add("addSeconds", function(num) {
        this.setSeconds(this.getSeconds() + num);
        return this
    });
    add("zeroTime", function() {
        this.setMilliseconds(0);
        this.setSeconds(0);
        this.setMinutes(0);
        this.setHours(0);
        return this
    });
    add("asString", function(format) {
        var r = format || Date.format;
        return r.split('yyyy').join(this.getFullYear()).split('yy').join((this.getFullYear() + '').substring(2)).split('mmmm').join(this.getMonthName(false)).split('mmm').join(this.getMonthName(true)).split('mm').join(_zeroPad(this.getMonth() + 1)).split('dd').join(_zeroPad(this.getDate())).split('hh').join(_zeroPad(this.getHours())).split('min').join(_zeroPad(this.getMinutes())).split('ss').join(_zeroPad(this.getSeconds()))
    });
    Date.fromString = function(s, format) {
        var f = format || Date.format;
        var d = new Date('01/01/1977');
        var mLength = 0;
        var iM = f.indexOf('mmmm');
        if (iM > -1) {
            for (var i = 0; i < Date.monthNames.length; i++) {
                var mStr = s.substr(iM, Date.monthNames[i].length);
                if (Date.monthNames[i] == mStr) {
                    mLength = Date.monthNames[i].length - 4;
                    break
                }
            }
            d.setMonth(i)
        } else {
            iM = f.indexOf('mmm');
            if (iM > -1) {
                var mStr = s.substr(iM, 3);
                for (var i = 0; i < Date.abbrMonthNames.length; i++) {
                    if (Date.abbrMonthNames[i] == mStr)
                        break
                }
                d.setMonth(i)
            } else {
                d.setMonth(Number(s.substr(f.indexOf('mm'), 2)) - 1)
            }
        }
        var iY = f.indexOf('yyyy');
        if (iY > -1) {
            if (iM < iY) {
                iY += mLength
            }
            d.setFullYear(Number(s.substr(iY, 4)))
        } else {
            if (iM < iY) {
                iY += mLength
            }
            d.setFullYear(Number(Date.fullYearStart + s.substr(f.indexOf('yy'), 2)))
        }
        var iD = f.indexOf('dd');
        if (iM < iD) {
            iD += mLength
        }
        d.setDate(Number(s.substr(iD, 2)));
        if (isNaN(d.getTime())) {
            return false
        }
        return d
    };
    var _zeroPad = function(num) {
        var s = '0' + num;
        return s.substring(s.length - 2)
    }
})();
(function($) {
    $.fn.extend({renderCalendar: function(s) {
            var dc = function(a) {
                return document.createElement(a);
            };
            s = $.extend({}, $.fn.datePicker.defaults, s);
            if (s.showHeader != $.dpConst.SHOW_HEADER_NONE) {
                var headRow = $(dc("tr"));
                for (var i = Date.firstDayOfWeek; i < Date.firstDayOfWeek + 7; i++) {
                    var weekday = i % 7;
                    var day = Date.dayNames[weekday];
                    headRow.append(jQuery(dc("th")).attr({scope: "col", abbr: day, title: day, "class": (weekday == 0 || weekday == 6 ? "weekend" : "weekday")}).html(s.showHeader == $.dpConst.SHOW_HEADER_SHORT ? day.substr(0, 1) : day));
                }
            }
            var calendarTable = $(dc("table")).attr({cellspacing: 2}).addClass("jCalendar").append((s.showHeader != $.dpConst.SHOW_HEADER_NONE ? $(dc("thead")).append(headRow) : dc("thead")));
            var tbody = $(dc("tbody"));
            var today = (new Date()).zeroTime();
            today.setHours(12);
            var month = s.month == undefined ? today.getMonth() : s.month;
            var year = s.year || today.getFullYear();
            var currentDate = (new Date(year, month, 1, 12, 0, 0));
            var firstDayOffset = Date.firstDayOfWeek - currentDate.getDay() + 1;
            if (firstDayOffset > 1) {
                firstDayOffset -= 7;
            }
            var weeksToDraw = Math.ceil(((-1 * firstDayOffset + 1) + currentDate.getDaysInMonth()) / 7);
            currentDate.addDays(firstDayOffset - 1);
            var doHover = function(firstDayInBounds) {
                return function() {
                    if (s.hoverClass) {
                        var $this = $(this);
                        if (!s.selectWeek) {
                            $this.addClass(s.hoverClass);
                        } else {
                            if (firstDayInBounds && !$this.is(".disabled")) {
                                $this.parent().addClass("activeWeekHover");
                            }
                        }
                    }
                };
            };
            var unHover = function() {
                if (s.hoverClass) {
                    var $this = $(this);
                    $this.removeClass(s.hoverClass);
                    $this.parent().removeClass("activeWeekHover");
                }
            };
            var w = 0;
            while (w++ < weeksToDraw) {
                var r = jQuery(dc("tr"));
                var firstDayInBounds = s.dpController ? currentDate > s.dpController.startDate : false;
                for (var i = 0; i < 7; i++) {
                    var thisMonth = currentDate.getMonth() == month;
                    var d = $(dc("td")).text(currentDate.getDate() + "").addClass((thisMonth ? "current-month " : "other-month ") + (currentDate.isWeekend() ? "weekend " : "weekday ") + (thisMonth && currentDate.getTime() == today.getTime() ? "today " : "")).data("datePickerDate", currentDate.asString()).hover(doHover(firstDayInBounds), unHover);
                    r.append(d);
                    if (s.renderCallback) {
                        s.renderCallback(d, currentDate, month, year);
                    }
                    currentDate = new Date(currentDate.getFullYear(), currentDate.getMonth(), currentDate.getDate() + 1, 12, 0, 0);
                }
                tbody.append(r);
            }
            calendarTable.append(tbody);
            return this.each(function() {
                $(this).empty().append(calendarTable);
            });
        }, datePicker: function(s) {
            if (!$.event._dpCache) {
                $.event._dpCache = [];
            }
            s = $.extend({}, $.fn.datePicker.defaults, s);
            return this.each(function() {
                var $this = $(this);
                var alreadyExists = true;
                if (!this._dpId) {
                    this._dpId = $.guid++;
                    $.event._dpCache[this._dpId] = new DatePicker(this);
                    alreadyExists = false;
                }
                if (s.inline) {
                    s.createButton = false;
                    s.displayClose = false;
                    s.closeOnSelect = false;
                    $this.empty();
                }
                var controller = $.event._dpCache[this._dpId];
                controller.init(s);
                if (!alreadyExists && s.createButton) {
                    controller.button = $('<a href="#" class="dp-choose-date" title="' + $.dpText.TEXT_CHOOSE_DATE + '">' + $.dpText.TEXT_CHOOSE_DATE + "</a>").bind("click", function() {
                        $this.dpDisplay(this);
                        this.blur();
                        return false;
                    });
                    $this.after(controller.button);
                }
                if (!alreadyExists && $this.is(":text")) {
                    $this.bind("dateSelected", function(e, selectedDate, $td) {
                        this.value = selectedDate.asString();
                    }).bind("change", function() {
                        if (this.value == "") {
                            controller.clearSelected();
                        } else {
                            var d = Date.fromString(this.value);
                            if (d) {
                                controller.setSelected(d, true, true);
                            }
                        }
                    });
                    if (s.clickInput) {
                        $this.bind("click", function() {
                            $this.trigger("change");
                            $this.dpDisplay();
                        });
                    }
                    var d = Date.fromString(this.value);
                    if (this.value != "" && d) {
                        controller.setSelected(d, true, true);
                    }
                }
                $this.addClass("dp-applied");
            });
        }, dpSetDisabled: function(s) {
            return _w.call(this, "setDisabled", s);
        }, dpSetStartDate: function(d) {
            return _w.call(this, "setStartDate", d);
        }, dpSetEndDate: function(d) {
            return _w.call(this, "setEndDate", d);
        }, dpGetSelected: function() {
            var c = _getController(this[0]);
            if (c) {
                return c.getSelected();
            }
            return null;
        }, dpSetSelected: function(d, v, m, e) {
            if (v == undefined) {
                v = true;
            }
            if (m == undefined) {
                m = true;
            }
            if (e == undefined) {
                e = true;
            }
            return _w.call(this, "setSelected", Date.fromString(d), v, m, e);
        }, dpSetDisplayedMonth: function(m, y) {
            return _w.call(this, "setDisplayedMonth", Number(m), Number(y), true);
        }, dpDisplay: function(e) {
            return _w.call(this, "display", e);
        }, dpSetRenderCallback: function(a) {
            return _w.call(this, "setRenderCallback", a);
        }, dpSetPosition: function(v, h) {
            return _w.call(this, "setPosition", v, h);
        }, dpSetOffset: function(v, h) {
            return _w.call(this, "setOffset", v, h);
        }, dpClose: function() {
            return _w.call(this, "_closeCalendar", false, this[0]);
        }, dpRerenderCalendar: function() {
            return _w.call(this, "_rerenderCalendar");
        }, _dpDestroy: function() {
        }});
    var _w = function(f, a1, a2, a3, a4) {
        return this.each(function() {
            var c = _getController(this);
            if (c) {
                c[f](a1, a2, a3, a4);
            }
        });
    };
    function DatePicker(ele) {
        this.ele = ele;
        this.displayedMonth = null;
        this.displayedYear = null;
        this.startDate = null;
        this.endDate = null;
        this.showYearNavigation = null;
        this.closeOnSelect = null;
        this.displayClose = null;
        this.rememberViewedMonth = null;
        this.selectMultiple = null;
        this.numSelectable = null;
        this.numSelected = null;
        this.verticalPosition = null;
        this.horizontalPosition = null;
        this.verticalOffset = null;
        this.horizontalOffset = null;
        this.button = null;
        this.renderCallback = [];
        this.selectedDates = {};
        this.inline = null;
        this.context = "#dp-popup";
        this.settings = {};
    }
    $.extend(DatePicker.prototype, {init: function(s) {
            this.setStartDate(s.startDate);
            this.setEndDate(s.endDate);
            this.setDisplayedMonth(Number(s.month), Number(s.year));
            this.setRenderCallback(s.renderCallback);
            this.showYearNavigation = s.showYearNavigation;
            this.closeOnSelect = s.closeOnSelect;
            this.displayClose = s.displayClose;
            this.rememberViewedMonth = s.rememberViewedMonth;
            this.selectMultiple = s.selectMultiple;
            this.numSelectable = s.selectMultiple ? s.numSelectable : 1;
            this.numSelected = 0;
            this.verticalPosition = s.verticalPosition;
            this.horizontalPosition = s.horizontalPosition;
            this.hoverClass = s.hoverClass;
            this.setOffset(s.verticalOffset, s.horizontalOffset);
            this.inline = s.inline;
            this.settings = s;
            if (this.inline) {
                this.context = this.ele;
                this.display();
            }
        }, setStartDate: function(d) {
            if (d) {
                this.startDate = Date.fromString(d);
            }
            if (!this.startDate) {
                this.startDate = (new Date()).zeroTime();
            }
            this.setDisplayedMonth(this.displayedMonth, this.displayedYear);
        }, setEndDate: function(d) {
            if (d) {
                this.endDate = Date.fromString(d);
            }
            if (!this.endDate) {
                this.endDate = (new Date("12/31/2999"));
            }
            if (this.endDate.getTime() < this.startDate.getTime()) {
                this.endDate = this.startDate;
            }
            this.setDisplayedMonth(this.displayedMonth, this.displayedYear);
        }, setPosition: function(v, h) {
            this.verticalPosition = v;
            this.horizontalPosition = h;
        }, setOffset: function(v, h) {
            this.verticalOffset = parseInt(v) || 0;
            this.horizontalOffset = parseInt(h) || 0;
        }, setDisabled: function(s) {
            $e = $(this.ele);
            $e[s ? "addClass" : "removeClass"]("dp-disabled");
            if (this.button) {
                $but = $(this.button);
                $but[s ? "addClass" : "removeClass"]("dp-disabled");
                $but.attr("title", s ? "" : $.dpText.TEXT_CHOOSE_DATE);
            }
            if ($e.is(":text")) {
                $e.attr("disabled", s ? "disabled" : "");
            }
        }, setDisplayedMonth: function(m, y, rerender) {
            if (this.startDate == undefined || this.endDate == undefined) {
                return;
            }
            var s = new Date(this.startDate.getTime());
            s.setDate(1);
            var e = new Date(this.endDate.getTime());
            e.setDate(1);
            var t;
            if ((!m && !y) || (isNaN(m) && isNaN(y))) {
                t = new Date().zeroTime();
                t.setDate(1);
            } else {
                if (isNaN(m)) {
                    t = new Date(y, this.displayedMonth, 1);
                } else {
                    if (isNaN(y)) {
                        t = new Date(this.displayedYear, m, 1);
                    } else {
                        t = new Date(y, m, 1);
                    }
                }
            }
            if (t.getTime() < s.getTime()) {
                t = s;
            } else {
                if (t.getTime() > e.getTime()) {
                    t = e;
                }
            }
            var oldMonth = this.displayedMonth;
            var oldYear = this.displayedYear;
            this.displayedMonth = t.getMonth();
            this.displayedYear = t.getFullYear();
            if (rerender && (this.displayedMonth != oldMonth || this.displayedYear != oldYear)) {
                this._rerenderCalendar();
                $(this.ele).trigger("dpMonthChanged", [this.displayedMonth, this.displayedYear]);
            }
        }, setSelected: function(d, v, moveToMonth, dispatchEvents) {
            if (d < this.startDate || d.zeroTime() > this.endDate.zeroTime()) {
                return;
            }
            var s = this.settings;
            if (s.selectWeek) {
                d = d.addDays(-(d.getDay() - Date.firstDayOfWeek + 7) % 7);
                if (d < this.startDate) {
                    return;
                }
            }
            if (v == this.isSelected(d)) {
                return;
            }
            if (this.selectMultiple == false) {
                this.clearSelected();
            } else {
                if (v && this.numSelected == this.numSelectable) {
                    return;
                }
            }
            if (moveToMonth && (this.displayedMonth != d.getMonth() || this.displayedYear != d.getFullYear())) {
                this.setDisplayedMonth(d.getMonth(), d.getFullYear(), true);
            }
            this.selectedDates[d.asString()] = v;
            this.numSelected += v ? 1 : -1;
            var selectorString = "td." + (d.getMonth() == this.displayedMonth ? "current-month" : "other-month");
            var $td;
            $(selectorString, this.context).each(function() {
                if ($(this).data("datePickerDate") == d.asString()) {
                    $td = $(this);
                    if (s.selectWeek) {
                        $td.parent()[v ? "addClass" : "removeClass"]("selectedWeek");
                    }
                    $td[v ? "addClass" : "removeClass"]("selected");
                }
            });
            $("td", this.context).not(".selected")[this.selectMultiple && this.numSelected == this.numSelectable ? "addClass" : "removeClass"]("unselectable");
            if (dispatchEvents) {
                var s = this.isSelected(d);
                $e = $(this.ele);
                var dClone = Date.fromString(d.asString());
                $e.trigger("dateSelected", [dClone, $td, s]);
                $e.trigger("change");
            }
        }, isSelected: function(d) {
            return this.selectedDates[d.asString()];
        }, getSelected: function() {
            var r = [];
            for (var s in this.selectedDates) {
                if (this.selectedDates[s] == true) {
                    r.push(Date.fromString(s));
                }
            }
            return r;
        }, clearSelected: function() {
            this.selectedDates = {};
            this.numSelected = 0;
            $("td.selected", this.context).removeClass("selected").parent().removeClass("selectedWeek");
        }, display: function(eleAlignTo) {
            if ($(this.ele).is(".dp-disabled")) {
                return;
            }
            eleAlignTo = eleAlignTo || this.ele;
            var c = this;
            var $ele = $(eleAlignTo);
            var eleOffset = $ele.offset();
            var $createIn;
            var attrs;
            var attrsCalendarHolder;
            var cssRules;
            if (c.inline) {
                $createIn = $(this.ele);
                attrs = {id: "calendar-" + this.ele._dpId, "class": "dp-popup dp-popup-inline"};
                $(".dp-popup", $createIn).remove();
                cssRules = {};
            } else {
                $createIn = $("body");
                attrs = {id: "dp-popup", "class": "dp-popup"};
                cssRules = {top: eleOffset.top + c.verticalOffset, left: eleOffset.left + c.horizontalOffset};
                var _checkMouse = function(e) {
                    var el = e.target;
                    var cal = $("#dp-popup")[0];
                    while (true) {
                        if (el == cal) {
                            return true;
                        } else {
                            if (el == document) {
                                c._closeCalendar();
                                return false;
                            } else {
                                el = $(el).parent()[0];
                            }
                        }
                    }
                };
                this._checkMouse = _checkMouse;
                c._closeCalendar(true);
                $(document).bind("keydown.datepicker", function(event) {
                    if (event.keyCode == 27) {
                        c._closeCalendar();
                    }
                });
            }
            if (!c.rememberViewedMonth) {
                var selectedDate = this.getSelected()[0];
                if (selectedDate) {
                    selectedDate = new Date(selectedDate);
                    this.setDisplayedMonth(selectedDate.getMonth(), selectedDate.getFullYear(), false);
                }
            }
            $createIn.append($("<div></div>").attr(attrs).css(cssRules).append($("<h2></h2>"), $('<div class="dp-nav-prev"></div>').append($('<a class="dp-nav-prev-year" href="#" title="' + $.dpText.TEXT_PREV_YEAR + '">&lt;&lt;</a>').bind("click", function() {
                return c._displayNewMonth.call(c, this, 0, -1);
            }), $('<a class="dp-nav-prev-month" href="#" title="' + $.dpText.TEXT_PREV_MONTH + '">&lt;</a>').bind("click", function() {
                return c._displayNewMonth.call(c, this, -1, 0);
            })), $('<div class="dp-nav-next"></div>').append($('<a class="dp-nav-next-year" href="#" title="' + $.dpText.TEXT_NEXT_YEAR + '">&gt;&gt;</a>').bind("click", function() {
                return c._displayNewMonth.call(c, this, 0, 1);
            }), $('<a class="dp-nav-next-month" href="#" title="' + $.dpText.TEXT_NEXT_MONTH + '">&gt;</a>').bind("click", function() {
                return c._displayNewMonth.call(c, this, 1, 0);
            })), $('<div class="dp-calendar"></div>')).bgIframe());
            var $pop = this.inline ? $(".dp-popup", this.context) : $("#dp-popup");
            if (this.showYearNavigation == false) {
                $(".dp-nav-prev-year, .dp-nav-next-year", c.context).css("display", "none");
            }
            if (this.displayClose) {
                $pop.append($('<a href="#" id="dp-close">' + $.dpText.TEXT_CLOSE + "</a>").bind("click", function() {
                    c._closeCalendar();
                    return false;
                }));
            }
            c._renderCalendar();
            $(this.ele).trigger("dpDisplayed", $pop);
            if (!c.inline) {
                if (this.verticalPosition == $.dpConst.POS_BOTTOM) {
                    $pop.css("top", eleOffset.top + $ele.height() - $pop.height() + c.verticalOffset);
                }
                if (this.horizontalPosition == $.dpConst.POS_RIGHT) {
                    $pop.css("left", eleOffset.left + $ele.width() - $pop.width() + c.horizontalOffset);
                }
                $(document).bind("mousedown.datepicker", this._checkMouse);
            }
        }, setRenderCallback: function(a) {
            if (a == null) {
                return;
            }
            if (a && typeof (a) == "function") {
                a = [a];
            }
            this.renderCallback = this.renderCallback.concat(a);
        }, cellRender: function($td, thisDate, month, year) {
            var c = this.dpController;
            var d = new Date(thisDate.getTime());
            $td.bind("click", function() {
                var $this = $(this);
                if (!$this.is(".disabled")) {
                    c.setSelected(d, !$this.is(".selected") || !c.selectMultiple, false, true);
                    if (c.closeOnSelect) {
                        if (c.settings.autoFocusNextInput) {
                            var ele = c.ele;
                            var found = false;
                            $(":input", ele.form).each(function() {
                                if (found) {
                                    $(this).focus();
                                    return false;
                                }
                                if (this == ele) {
                                    found = true;
                                }
                            });
                        } else {
                            c.ele.focus();
                        }
                        c._closeCalendar();
                    }
                }
            });
            if (c.isSelected(d)) {
                $td.addClass("selected");
                if (c.settings.selectWeek) {
                    $td.parent().addClass("selectedWeek");
                }
            } else {
                if (c.selectMultiple && c.numSelected == c.numSelectable) {
                    $td.addClass("unselectable");
                }
            }
        }, _applyRenderCallbacks: function() {
            var c = this;
            $("td", this.context).each(function() {
                for (var i = 0; i < c.renderCallback.length; i++) {
                    $td = $(this);
                    c.renderCallback[i].apply(this, [$td, Date.fromString($td.data("datePickerDate")), c.displayedMonth, c.displayedYear]);
                }
            });
            return;
        }, _displayNewMonth: function(ele, m, y) {
            if (!$(ele).is(".disabled")) {
                this.setDisplayedMonth(this.displayedMonth + m, this.displayedYear + y, true);
            }
            ele.blur();
            return false;
        }, _rerenderCalendar: function() {
            this._clearCalendar();
            this._renderCalendar();
        }, _renderCalendar: function() {
            $("h2", this.context).html((new Date(this.displayedYear, this.displayedMonth, 1)).asString($.dpText.HEADER_FORMAT));
            $(".dp-calendar", this.context).renderCalendar($.extend({}, this.settings, {month: this.displayedMonth, year: this.displayedYear, renderCallback: this.cellRender, dpController: this, hoverClass: this.hoverClass}));
            if (this.displayedYear == this.startDate.getFullYear() && this.displayedMonth == this.startDate.getMonth()) {
                $(".dp-nav-prev-year", this.context).addClass("disabled");
                $(".dp-nav-prev-month", this.context).addClass("disabled");
                $(".dp-calendar td.other-month", this.context).each(function() {
                    var $this = $(this);
                    if (Number($this.text()) > 20) {
                        $this.addClass("disabled");
                    }
                });
                var d = this.startDate.getDate();
                $(".dp-calendar td.current-month", this.context).each(function() {
                    var $this = $(this);
                    if (Number($this.text()) < d) {
                        $this.addClass("disabled");
                    }
                });
            } else {
                $(".dp-nav-prev-year", this.context).removeClass("disabled");
                $(".dp-nav-prev-month", this.context).removeClass("disabled");
                var d = this.startDate.getDate();
                if (d > 20) {
                    var st = this.startDate.getTime();
                    var sd = new Date(st);
                    sd.addMonths(1);
                    if (this.displayedYear == sd.getFullYear() && this.displayedMonth == sd.getMonth()) {
                        $(".dp-calendar td.other-month", this.context).each(function() {
                            var $this = $(this);
                            if (Date.fromString($this.data("datePickerDate")).getTime() < st) {
                                $this.addClass("disabled");
                            }
                        });
                    }
                }
            }
            if (this.displayedYear == this.endDate.getFullYear() && this.displayedMonth == this.endDate.getMonth()) {
                $(".dp-nav-next-year", this.context).addClass("disabled");
                $(".dp-nav-next-month", this.context).addClass("disabled");
                $(".dp-calendar td.other-month", this.context).each(function() {
                    var $this = $(this);
                    if (Number($this.text()) < 14) {
                        $this.addClass("disabled");
                    }
                });
                var d = this.endDate.getDate();
                $(".dp-calendar td.current-month", this.context).each(function() {
                    var $this = $(this);
                    if (Number($this.text()) > d) {
                        $this.addClass("disabled");
                    }
                });
            } else {
                $(".dp-nav-next-year", this.context).removeClass("disabled");
                $(".dp-nav-next-month", this.context).removeClass("disabled");
                var d = this.endDate.getDate();
                if (d < 13) {
                    var ed = new Date(this.endDate.getTime());
                    ed.addMonths(-1);
                    if (this.displayedYear == ed.getFullYear() && this.displayedMonth == ed.getMonth()) {
                        $(".dp-calendar td.other-month", this.context).each(function() {
                            var $this = $(this);
                            var cellDay = Number($this.text());
                            if (cellDay < 13 && cellDay > d) {
                                $this.addClass("disabled");
                            }
                        });
                    }
                }
            }
            this._applyRenderCallbacks();
        }, _closeCalendar: function(programatic, ele) {
            if (!ele || ele == this.ele) {
                $(document).unbind("mousedown.datepicker");
                $(document).unbind("keydown.datepicker");
                this._clearCalendar();
                $("#dp-popup a").unbind();
                $("#dp-popup").empty().remove();
                if (!programatic) {
                    $(this.ele).trigger("dpClosed", [this.getSelected()]);
                }
            }
        }, _clearCalendar: function() {
            $(".dp-calendar td", this.context).unbind();
            $(".dp-calendar", this.context).empty();
        }});
    $.dpConst = {SHOW_HEADER_NONE: 0, SHOW_HEADER_SHORT: 1, SHOW_HEADER_LONG: 2, POS_TOP: 0, POS_BOTTOM: 1, POS_LEFT: 0, POS_RIGHT: 1, DP_INTERNAL_FOCUS: "dpInternalFocusTrigger"};
    $.dpText = {TEXT_PREV_YEAR: "Previous year", TEXT_PREV_MONTH: "Previous month", TEXT_NEXT_YEAR: "Next year", TEXT_NEXT_MONTH: "Next month", TEXT_CLOSE: "Close", TEXT_CHOOSE_DATE: "Choose date", HEADER_FORMAT: "mmmm yyyy"};
    $.dpVersion = "$Id: jquery.datePicker.js 102 2010-09-13 14:00:54Z kelvin.luck $";
    $.fn.datePicker.defaults = {month: undefined, year: undefined, showHeader: $.dpConst.SHOW_HEADER_SHORT, startDate: undefined, endDate: undefined, inline: false, renderCallback: null, createButton: true, showYearNavigation: true, closeOnSelect: true, displayClose: false, selectMultiple: false, numSelectable: Number.MAX_VALUE, clickInput: false, rememberViewedMonth: true, selectWeek: false, verticalPosition: $.dpConst.POS_TOP, horizontalPosition: $.dpConst.POS_LEFT, verticalOffset: 0, horizontalOffset: 0, hoverClass: "dp-hover", autoFocusNextInput: false};
    function _getController(ele) {
        if (ele._dpId) {
            return $.event._dpCache[ele._dpId];
        }
        return false;
    }
    if ($.fn.bgIframe == undefined) {
        $.fn.bgIframe = function() {
            return this;
        };
    }
    $(window).bind("unload", function() {
        var els = $.event._dpCache || [];
        for (var i in els) {
            $(els[i].ele)._dpDestroy();
        }
    });
})(jQuery);
jQuery.fn.pagination = function(maxentries, opts) {
    jQuery.fn.pagination.setPage = function(x) {
        current_page = parseInt(x);
        drawLinks();
    };
    if (maxentries == undefined || maxentries == 0) {
        return
    }
    opts = jQuery.extend({initial_page: 0, num_display_entries: 4, current_page: 0, num_edge_entries: 1, link_to: "#", prev_text: "&lt;", next_text: "&gt;", ellipse_text: "...", prev_show_always: false, next_show_always: false, callback: function(index) {
            $('#updater').addLoader();
            $('#checkall').attr('checked', false);
            $.post($('#currentlist').attr('href'), {page: index}, function(data) {
                var resp = parse_response(data);
                if (resp) {
                    $('#updater').html(resp);
                    $('.check').unbind('click');
                    $('.currentpage').val(index);
                    $('.check').click(checkEl)
                }
            });
            return false
        }}, opts || {});
    var current_page = opts.current_page;
    maxentries = (!maxentries || maxentries < 0) ? 1 : maxentries;
    opts.items_per_page = (!opts.items_per_page || opts.items_per_page < 0) ? 1 : opts.items_per_page;
    function getInterval() {
        var ne_half = Math.ceil(opts.num_display_entries / 2);
        var np = maxentries;
        var upper_limit = np - opts.num_display_entries;
        var start = current_page > ne_half ? Math.max(Math.min(current_page - ne_half, upper_limit), 0) : 0;
        var end = current_page > ne_half ? Math.min(current_page + ne_half, np) : Math.min(opts.num_display_entries, np);
        return[start, end]
    }
    ;
    function pageSelected(page_id, evt) {
        current_page = page_id;
        drawLinks();
        var continuePropagation = opts.callback(page_id);
        if (!continuePropagation) {
            if (evt.stopPropagation) {
                evt.stopPropagation()
            } else {
                evt.cancelBubble = true
            }
        }
        return continuePropagation
    }
    ;
    var containers = this;
    function drawLinks() {
        containers.each(function() {
            var panel = jQuery(this);
            panel.empty();
            var interval = getInterval();
            var np = maxentries;
            var getClickHandler = function(page_id) {
                return function(evt) {
                    return pageSelected(page_id, evt)
                }
            };
            var appendItem = function(page_id, appendopts) {
                page_id = page_id < 0 ? 0 : (page_id < np ? page_id : np - 1);
                appendopts = jQuery.extend({text: page_id + 1, classes: ""}, appendopts || {});
                if (page_id == current_page) {
                    var lnk = jQuery("<span class='current'>" + (appendopts.text) + "</span>")
                } else {
                    var lnk = jQuery("<a>" + (appendopts.text) + "</a>").bind("click", getClickHandler(page_id)).attr('href', opts.link_to.replace(/__id__/, page_id))
                }
                if (appendopts.classes) {
                    lnk.addClass(appendopts.classes)
                }
                panel.append(lnk)
            };
            if (opts.prev_text && (current_page > 0 || opts.prev_show_always)) {
                appendItem(current_page - 1, {text: opts.prev_text, classes: "prev"})
            }
            if (interval[0] > 0 && opts.num_edge_entries > 0) {
                var end = Math.min(opts.num_edge_entries, interval[0]);
                for (var i = 0; i < end; i++) {
                    appendItem(i)
                }
                if (opts.num_edge_entries < interval[0] && opts.ellipse_text) {
                    jQuery("<span>" + opts.ellipse_text + "</span>").appendTo(panel)
                }
            }
            for (var i = interval[0]; i < interval[1]; i++) {
                appendItem(i)
            }
            if (interval[1] < np && opts.num_edge_entries > 0) {
                if (np - opts.num_edge_entries > interval[1] && opts.ellipse_text) {
                    jQuery("<span>" + opts.ellipse_text + "</span>").appendTo(panel)
                }
                var begin = Math.max(np - opts.num_edge_entries, interval[1]);
                for (var i = begin; i < np; i++) {
                    appendItem(i)
                }
            }
            if (opts.next_text && (current_page < np - 1 || opts.next_show_always)) {
                appendItem(current_page + 1, {text: opts.next_text, classes: "next"})
            }
        })
    }
    ;
    drawLinks();
    if (current_page != opts.initial_page) {
        opts.callback(current_page)
    }
};
(function(a) {
    a.event.special.textchange = {
        setup: function() {
            a(this).bind("keyup.textchange", a.event.special.textchange.handler);
            a(this).bind("cut.textchange paste.textchange input.textchange", a.event.special.textchange.delayedHandler)
        }, teardown: function() {
            a(this).unbind(".textchange")
        }, handler: function() {
            a.event.special.textchange.triggerIfChanged(a(this))
        }, delayedHandler: function() {
            var b = a(this);
            setTimeout(function() {
                a.event.special.textchange.triggerIfChanged(b)
            }, 25)
        }, triggerIfChanged: function(b) {
            var c =
                b.attr("contenteditable") ? b.html() : b.val();
            if (c !== b.data("lastValue")) {
                b.trigger("textchange", b.data("lastValue"));
                b.data("lastValue", c)
            }
        }
    };
})(jQuery);
$.fn.serializeObject = function()
{
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};
$.extend($.fn, {
    vTip: function(target) {
        var xOffset = 5;
        var yOffset = 2;
        $(this).not('.vtip_applied').hover(function(e) {
            this.t = this.title;
            this.title = '';
            this.top = (e.pageY + yOffset);
            this.left = (e.pageX + xOffset);

            $('body').append('<p id="vtip">' + this.t + '</p>');
            $('p#vtip').css("top", this.top + "px").css("left", this.left + "px").fadeIn("fast");
        }, function() {
            this.title = this.t;
            $("p#vtip").hide().remove();
        }).addClass('vtip_applied');
    },
    slideToElement: function(target) {
        var $target = $('a[name=' + target + ']');
        if ($target.length) {
            var targetOffset = $target.offset().top;
            $('html,body').animate({
                scrollTop: targetOffset - 100
            }, 500, 'linear', function() {
            });
            return false;
        }
    },
    dropdownMenu: function(o, callback) {
        // Defaults

        $(this).click(function(event) {
            event.preventDefault();
            var menu = $(this),
                activated = menu.hasClass('activated'),
                listId = menu.attr('id'),
                menuOffset = menu.offset(),
                menuHeight = menu.outerHeight(),
                w = $(window),
                scrollTop = w.scrollTop(),
                windowHeight = w.height(),
                offset = $.extend({}, menuOffset);

            if (menu.is('.disabled'))
                return false;

            $(".contextMenu").hide();
            $('.dropdown-menu-on').removeClass('dropdown-menu-on activated');
            if (activated)
                return false;

            menu.addClass('activated dropdown-menu-on');

            if (listId) {
                offset.top += menuHeight;
                var list = $('#' + listId + '_m');

                list.addClass('contextMenu').show()
                    .find('a').unbind('.dropdown').bind('click.dropdown', function(e) {
                    var a = $(this),
                        li = a.parent();

                    menu.removeClass('activated');
                    $(".contextMenu").hide();
                    $(document).unbind('.dropdown');

                    if (li.is('.disabled'))
                        return false;
                    if (a.is('.directly')) {
                        a.unbind('.dropdown').click();
                        return true;
                    }
                    if (typeof callback == 'function')
                        callback(a.attr('href'), menu, e, a.html());
                    return false;
                });

                var listHeight = list.outerHeight();
                if (scrollTop + windowHeight < menuOffset.top + menuHeight + listHeight) {

                    if (menuOffset.top - listHeight > scrollTop)
                        offset.top = menuOffset.top - listHeight;
                    else {
                        var limHeight = Math.max(scrollTop + windowHeight - (menuOffset.top + menuHeight), menuOffset.top - scrollTop),
                            targetHeight = 30,
                            group = [[]],
                            gi = 0,
                            filter = function() {
                                return !$(this).hasClass('wrapp')
                            };

                        list.find('> li, .wrapp > ul > li').filter(filter).each(function() {
                            var li = $(this);
                            if (targetHeight < limHeight)
                                targetHeight += li.height();
                            else {
                                targetHeight = li.height() + 30;
                                gi++;
                                group[gi] = [];
                            }
                            group[gi].push(li.detach());
                        });

                        list.children().remove();
                        for (var i = 0; i < group.length; i++) {
                            var wrapp = $('<li class="wrapp"><ul></ul></li>');
                            wrapp.appendTo(list).find('ul').append(group[i]);
                        }
                        list.width(group.length * 160)

                        listHeight = list.outerHeight();
                        if (menuOffset.top - listHeight > scrollTop)
                            offset.top = menuOffset.top - listHeight;
                    }
                }

                var listWidth = list.outerWidth();
                if (offset.left + listWidth > w.width())
                    offset.left -= (offset.left + listWidth) - w.width();

                list.offset(offset)
            }

            $(document).unbind('.dropdown').bind('click.dropdown keypress.dropdown', function(e) {
                if (e.keyCode == 27 || (!menu.is(e.target) && !menu.find(e.target).length)) {
                    $(document).unbind('.dropdown');
                    list.hide();
                    menu.removeClass('activated dropdown-menu-on');
                }
                return false;
            });
            return false;
        })

        return $(this);
    }, SmartSearch: function(o, callback) {

        var defaults = {
            target: '#smartres',
            url: '?cmd=search&lightweight=1',
            submitel: '#search_submiter',
            results: '#smartres-results',
            container: '#search_form_container'
        };

        o = $.extend({}, defaults, o || {});
        $(this).each(function() {
            var el = $(this);
            var offset = $(el).offset();
            var height = $(el).height();
            var x = offset.left;
            var y = height + offset.top + 4;
            var x2 = $(el).position().left;
            var y2 = $(el).position().top + 4 + height;
            var ending_right = ($(window).width() - (x + el.outerWidth()));

            $(o.target).css({top: y, right: ending_right});

            $(o.submitel).click(function() {
                $(this).addClass('search_loading');
                $.post(o.url, {
                    query: el.val()
                }, function(data) {
                    $(o.submitel).removeClass('search_loading');
                    var resp = parse_response(data);
                    if (resp !== false && typeof (resp) == 'string') {
                        el.SmartSearchShow(resp, el.val(), o);
                    } else {
                        el.SmartSearchHide(o);
                    }
                });
                return false;
            });
            $(this).keydown(function(event) {
                if (event.keyCode == 13) {
                    $(o.submitel).click();
                }
            });

        });
        return $(this);
    }, ShowNicely: function() {
        var e = $(this);
        e.addClass('shownice').show();
        setTimeout(function(el) {
            $(e).removeClass('shownice');
        }, 1000, e);


        return($(this));

    }, scrollToEl: function() {
        if ($(this).length) {
            var targetOffset = $(this).offset().top;
            $('html,body').animate({
                scrollTop: targetOffset - 100
            }, 500, 'linear', function() {

            });
        }
        return($(this));
    }, SmartSearchHide: function(o) {
        $(o.target).fadeOut('fast', function() {
            $(o.results).html('');
        });
        $(o.container).removeClass('resultsin');

        return($(this));

    }, SmartSearchShow: function(content, term, o) {
        $(o.results).html(content);
        var t = term.split(" ");
        for (var i in t) {
            $('li.result', o.results).highlight(t[i].replace('*', ''), {className: 'h'});
        }

        $(o.container).addClass('resultsin');
        $(o.target).fadeIn('fast');
        var el = $(this);
        $(document).click(function() {
            $(document).unbind('click');
            el.SmartSearchHide(o);
            return false;
        });
        $('a', o.target).click(function(e) {
            return true;
        }).mousedown(function(e) {
            e.stopPropagation();
            if (e.which == 2) {
                e.preventDefault();
                $(this).attr('target', '_blank').click().removeAttr('target');

            }
            $(this).click();
            return true;
        });



        return($(this));
    }, HoverMenu: function(o, callback) {

        $(this).each(function(n) {
            var el = $(this);
            var offset = el.offset();
            var height = el.height();
            var x = offset.left;
            var y = height + offset.top;     //+padding

            $('.submenu', '#menushelf').eq(n).css({top: y, left: x});

            el.hover(function() {
                $(this).HoverMenuShow(n);
            }, function() {
                $(this).HoverTimer();
            });


        });

        $('.submenu', '#menushelf').hover(function() {
            $(this).HoverCancelTimer();
        }, function() {
            $(this).HoverMenuHide();
        });
        return $(this);
    }, TabbedMenu: function(o) {
        var el = o.elem ? o.elem : '.tabb';
        var choice = o.picker ? o.picker : 'a.tchoice';
        var activeclass = o.aclass ? o.aclass : 'picked';
        var picked = o.picked ? parseInt(o.picked) : 0;
        var picker_id = o.picker_id ? o.picker_id : 'picked_tab';
        var t = $(this);
        $(el).hide();
        $(el).eq(picked).show();
        $('' + choice + ':not(.directlink)').eq(picked).addClass(activeclass);
        if (!t.find('#' + picker_id).length && !o.picktab)
            t.append('<input type="hidden" value="' + picked + '" name="' + picker_id + '" id="' + picker_id + '"/>');
        t.find('' + choice + ':not(.directlink)').each(function(n) {
            $(this).click(function() {
                if ($(this).hasClass('disabled'))
                    return false;
                if (!o.picktab)
                    t.find('#' + picker_id).val(n);
                $(el).hide();
                $(el).eq(n).show();
                $('' + choice).removeClass(activeclass);


                $(this).addClass(activeclass);
                if ($(this).find('span.notification').length) {
                    $(this).find('span.notification').removeClass('notification');
                }

                return false;

            });

        });

        return($(this));

    }, HoverMenuHide: function() {

        $('.mainmenu', '#mmcontainer').removeClass('active');
        $('.submenu', '#menushelf').hide();
        return($(this));

    }, HoverMenuShow: function(elem) {
        var el = $(this);
        el.HoverCancelTimer();
        $('.submenu', '#menushelf').hide();
        $('.mainmenu', '#mmcontainer').removeClass('active');
        $('.submenu', '#menushelf').eq(elem).show();
        el.addClass('active');

        return($(this));
    }, HoverTimer: function() {
        timing = setTimeout(function() {
            $('.mainmenu', '#mmcontainer').removeClass('active');
            $('.submenu', '#menushelf').hide();
        }, 200);

        return($(this));

    }, HoverCancelTimer: function() {
        if (timing) {
            clearTimeout(timing);
            timing = null;
        }

        return($(this));

    }, taskMgr: function(o, callback) {

        //if( o.movement == undefined ) o.movement=3;

        $(this).each(function() {


            $(this).taskMgrCountEI();

            var el = $(this);
            el.find('span.progress').progressBar(0, {max: maximum}).addClass('hidden').hide();
            el.find('a.showlog').hide();
            el.find('a.showlog').mouseover(function() {
                el.taskMgrShow();
                $(this).hide();
                return false;
            });
            el.hover(function() {
            }, function() {
                $(this).taskMgrHide();
            });
            $(this).taskMgrCheckInterval();

        });
        return $(this);
    },
    taskMgrCountEI: function() {
        if ($('LI.info', '#taskMGR').length > 0)
            $('#numinfos').html($('LI.info', '#taskMGR').length).show();
        else
            $('#numinfos').html('0');
        if ($('LI.error', '#taskMGR').length > 0)
            $('#numerrors').html($('LI.error', '#taskMGR').length).show();
        else
            $('#numerrors').html('0');
    },
    // Public Methods
    taskMgrProgress: function(current) {
        var el = $(this);
        el.taskMgrCheckVisibility();
        var prog = $(this).find('span.progress');
        if (parseInt(current) == 0) {
            prog.progressBar(maximum).fadeOut('fast', function() {
                el.taskMgrCheckVisibility();
            }).addClass('hidden').removeClass('visible');
            el.taskMgrCountEI();

        } else {
            $('#numinfos').hide();
            $('#numerrors').hide();
            if (prog.hasClass('hidden')) {
                prog.removeClass('hidden').addClass('visible').fadeIn();

            }
            prog.progressBar(maximum - parseInt(current), {
                max: maximum,
                callback: function(data) {
                    if (data.max == data.running_value) {
                        prog.fadeOut().addClass('hidden').removeClass('visible');
                        el.taskMgrCountEI();
                    }
                }
            });
        }

        return($(this));
    },
    taskMgrAddInfo: function(info) {
        var t = new Date();
        var el = $(this);
        var ss = t.getMinutes();
        if (ss < 10) {
            ss = "0" + ss;
        }

        var s = t.getHours().toString() + ':' + ss;
        var i = parseInt($('#numinfos').html());
        $('#numinfos').html(i + 1).show();
        el.find('ul').prepend('<li class="info visible">' + s + ' ' + info + '<br/></li>');
        el.taskMgrCheckInterval();
        el.addClass('newel');

        return($(this));
    },
    taskMgrAddError: function(error) {
        var i = parseInt($('#numerrors').html());
        var t = new Date();
        var el = $(this);
        var ss = t.getMinutes();
        if (ss < 10) {
            ss = "0" + ss;
        }
        var s = t.getHours().toString() + ':' + ss;
        $('#numerrors').html(i + 1).show();
        el.find('ul').prepend('<li class="error visible">' + s + ' ' + error + '<br/></li>');
        el.taskMgrCheckInterval();
        el.addClass('newel');

        return($(this));
    },
    taskMgrShow: function() {
        clearTimeout(t);
        t = '';
        $(this).addClass('taskAll').find('li').show();
        return($(this));
    },
    taskMgrCheckVisibility: function() {
        var el = $(this);
        if (el.find('LI').length > 0 || el.find('span.progress').hasClass('visible')) {
            el.find('a.showlog').show();

            el.show();
        } else {
            el.hide();

        }

        return($(this));
    },
    taskQuickLoadShow: function() {
        if ($(this).find('span.progress').hasClass('visible')) {

        } else {
            $(this).show().find('.small-load').show();
        }

        return($(this));
    },
    taskQuickLoadHide: function() {
        $(this).find('.small-load').hide();
        return($(this));
    },
    taskMgrHide: function() {
        var el = $(this);
        el.removeClass('taskAll');
        el.find('li.hidden').hide();
        if (el.find('LI').length > 0)
            el.find('a.showlog').show();

        return(el.taskMgrCheckInterval());
    },
    taskMgrCheckInterval: function() {
        var el = $(this);
        el.taskMgrCheckVisibility();
        var len = el.find('LI.visible').length;
        if (len > 0) {
            if (navigator.userAgent.match(/MSIE 6/i))
            {
                el.css({top: document.documentElement.scrollTop});
            }
            t = setTimeout(function() {
                if (el.attr('class') != 'newel taskAll' && el.attr('class') != 'taskAll') {
                    //    alert(el.attr('class'));
                    $(this).find('LI.visible:last').slideUp('slow', function() {
                        $(this).removeClass('visible').addClass('hidden');
                    });
                    el.taskMgrCheckInterval();
                }
            }, 2000);


        } else {


            el.removeClass('newel');



            // clearInterval(t);
            // t='';
            //stick to top, change color


        }

        return($(this));
    }, addLoader: function(margin) {

        var that = this.eq(0),
            offset = that.position(),
            loader = $('#preloader').hide();
        if (offset === null) {
            return this;
        }
        var totalWidth = that.outerWidth(!!margin),
            totalHeight = that.outerHeight(!!margin);
        if (!margin) {
            offset.left += parseInt(that.css('margin-left'));
            offset.top += parseInt(that.css('margin-top'));
        }
        if (loader.length && loader.parent().is(that)) {
            loader.css({width: totalWidth, height: totalHeight, top: offset.top, left: offset.left}).show();
        } else {
            if (loader.length)
                loader.remove();
            $('<div id="preloader" ></div>').css({position: 'absolute', width: totalWidth, height: totalHeight, top: offset.top, left: offset.left}).appendTo(that);
        }
        return this;
    },
    hideLoader: function() {
        $('#preloader').hide();
        return($(this));
    }


});
(function($) {
    $.extend({
        progressBar: new function() {

            this.defaults = {
                steps: 20, // steps taken to reach target
                step_duration: 20,
                max: 100, // Upon 100% i'd assume, but configurable

                // Or otherwise, set to 'fraction'
                width: 120, // Width of the progressbar - don't forget to adjust your image too!!!												// Image to use in the progressbar. Can be a single image too: 'images/progressbg_green.gif'
                height: 12, // Height of the progressbar - don't forget to adjust your image too!!!
                callback: null, // Calls back with the config object that has the current percentage, target percentage, current image, etc
                boxImage: 'images/progressbar.gif', // boxImage : image around the progress bar
                barImage: 'images/progressbg_blue.gif',
                // Internal use
                running_value: 0,
                value: 0,
                image: null
            };

            /* public methods */
            this.construct = function(arg1, arg2) {
                var argvalue = null;
                var argconfig = null;

                if (arg1 != null) {
                    if (!isNaN(arg1)) {
                        argvalue = arg1;
                        if (arg2 != null) {
                            argconfig = arg2;
                        }
                    } else {
                        argconfig = arg1;
                    }
                }

                return this.each(function(child) {
                    var pb = this;
                    var config = this.config;

                    if (argvalue != null && this.bar != null && this.config != null) {
                        this.config.value = argvalue;
                        if (argconfig != null)
                            pb.config = $.extend(this.config, argconfig);
                        config = pb.config;
                    } else {
                        var $this = $(this);
                        var config = $.extend({}, $.progressBar.defaults, argconfig);
                        config.id = $this[0].id ? $this[0].id : Math.ceil(Math.random() * 100000);	// random id, if none provided

                        if (argvalue == null)
                            argvalue = $this.html().replace("%", "");	// parse percentage

                        config.value = argvalue;
                        config.running_value = 0;
                        config.image = getBarImage(config);

                        $this.html("");
                        var bar = document.createElement('img');
                        var text = document.createElement('span');
                        var $bar = $(bar);
                        var $text = $(text);
                        pb.bar = $bar;

                        $bar.attr('id', config.id + "_pbImage");
                        $text.attr('id', config.id + "_pbText");

                        $bar.attr('src', config.boxImage);
                        $bar.attr('width', config.width);
                        $bar.css("width", config.width + "px");
                        $bar.css("height", config.height + "px");
                        $bar.css("background-image", "url(" + config.image + ")");
                        $bar.css("background-position", ((config.width * -1)) + 'px 50%');
                        $bar.css("padding", "0");
                        $bar.css("margin", "0");
                        $this.append($bar);
                        $this.append($text);
                    }

                    function getPercentage(config) {
                        return config.running_value * 100 / config.max;
                    }

                    function getBarImage(config) {
                        var image = config.barImage;

                        return image;
                    }



                    config.increment = Math.round((config.value - config.running_value) / config.steps);
                    if (config.increment < 0)
                        config.increment *= -1;
                    if (config.increment < 1)
                        config.increment = 1;

                    var t = setInterval(function() {
                        var pixels = config.width / 100;			// Define how many pixels go into 1%
                        var stop = false;

                        if (config.running_value > config.value) {
                            if (config.running_value - config.increment < config.value) {
                                config.running_value = config.value;
                            } else {
                                config.running_value -= config.increment;
                            }
                        }
                        else if (config.running_value < config.value) {
                            if (config.running_value + config.increment > config.value) {
                                config.running_value = config.value;
                            } else {
                                config.running_value += config.increment;
                            }
                        }

                        if (config.running_value == config.value)
                            clearInterval(t);

                        var $bar = $("#" + config.id + "_pbImage");
                        var $text = $("#" + config.id + "_pbText");
                        var image = getBarImage(config);
                        if (image != config.image) {
                            $bar.css("background-image", "url(" + image + ")");
                            config.image = image;
                        }
                        $bar.css("background-position", (((config.width * -1)) + (getPercentage(config) * pixels)) + 'px 50%');


                        if (config.callback != null && typeof (config.callback) == 'function')
                            config.callback(config);

                        pb.config = config;
                    }, config.step_duration);
                });
            };
        }
    });

    $.fn.extend({
        progressBar: $.progressBar.construct
    });

})(jQuery);

function isEmpty(obj) {
    for (var prop in obj) {
        if (obj.hasOwnProperty(prop))
            return false;
    }

    return true;
}

function ajax_update(url, params, update, swirl, append) {
    $('#taskMGR').taskQuickLoadShow();
    if (typeof (update) == 'string' && update && swirl && !append)
        $(update).html('<center><img src="ajax-loading.gif" /></center>');
    var o = {};
    if (params != undefined && isEmpty(params)) {
        params = {empty1m: 'param'};
    }
    $.post(url, params, function(data) {
        $('#taskMGR').taskQuickLoadHide();
        var resp = parse_response(data);

        if (resp == false) {
            if (typeof (update) == 'string' && update && !append)
                $(update).html('');

        }
        else {
            if (typeof (update) == 'function') {
                this.resp = resp;
                update.apply(this, arguments);
            }
            else if (update && !append && typeof (resp) == 'string') {
                $(update).html(resp);
            } else if (update && append) {
                $(update).append(resp);
            }

        }

    });


}
;

function accordion() {
    $('#accordion  div.sor').hide();
    $('#accordion  div.sor:first').show();
    $('#accordion  li a:first').addClass('opened');
    $('#accordion li a').click(
        function() {
            var checkElement = $(this).next();

            if ((checkElement.is('div')) && (checkElement.is(':visible'))) {
                $('#accordion li a').removeClass('opened');
                checkElement.hide();
                return false;
            }
            if ((checkElement.is('div')) && (!checkElement.is(':visible'))) {

                // $('#accordion div.sor:visible').hide();

                $('#accordion li a').removeClass('opened');

                checkElement.show().prev().addClass('opened');

                return false;
            }
        }
    );
}
;

var initload = 0;
function pops() {

    ajax_update('index.php', {
        stack: 'pop'
    }, function() {
        initload = 1;
    });
    setTimeout(function() {
        if (initload == 0) {
            $('#taskMGR').taskMgrProgress(1);
        }
    }, 400);

}
;

function sorterUpdate(low, high, total, pages) {
    if (typeof (low) != 'undefined') {
        $('#sorterlow').html(low);
    }
    if (typeof (high) != 'undefined') {
        $('#sorterhigh').html(high);
    }
    if (typeof (total) != 'undefined') {
        $('#sorterrecords').html(total);
    }
    if (typeof (pages) != 'undefined' && $('div.pagination').length) {
        var current = parseInt($('.pagination span.current').length && $('.pagination span.current').eq(0).html() || 1) - 1;
        $('div.pagination').html('').pagination(pages, {current_page: current, initial_page: current});
    }
}
function parse_response(data) {



    if (data.indexOf('<!-- {') != 0)
        return false;

    var codes = eval('(' + data.substr(data.indexOf('<!-- ') + 4, data.indexOf('-->') - 4) + ')');
    var i = 0;

    for (i = 0; i < codes.ERROR.length; i++) {
        $('#taskMGR').taskMgrAddError(codes.ERROR[i]);
    }

    for (i = 0; i < codes.INFO.length; i++) {
        $('#taskMGR').taskMgrAddInfo(codes.INFO[i]);
    }
    if (codes.EVAL) {
        for (i = 0; i < codes.EVAL.length; i++) {
            eval(codes.EVAL[i]);
        }
    }
    $('#taskMGR').taskMgrProgress(codes.STACK);
    if (codes.STACK > 0) {

        setTimeout('pops()', 10);
    }
    if (codes.STACK == 0 && codes.INFO.length > 0) {
        // update whole view

        if ($('.submiter').length > 0 && $('#currentlist').length > 0 && $('.pagination span.current').length > 0) {
            ajax_update($('#currentlist').attr('href') + '&page=' + (parseInt($('.pagination span.current').eq(0).html()) - 1) + '', {
                once: '1'
            }, $('#currentlist').attr('updater'), false);
        }
    }
    var retu = data.substr(data.indexOf('-->') + 3, data.length);
    if (retu == '')
        retu = true;
    return retu;


}
;





function filter(forms) {

    if ($('#currentlist').length > 0) {
        var tv = $('#content_tb');
        if (tv.length) {
            tv.addClass('searchon');
        }
        $('#updater').addLoader();
        ajax_update($('#currentlist').attr('href') + '&' + $(forms).serialize(), {
            page: (parseInt($('.pagination span.current').eq(0).html()) - 1)
        }, '#updater');
        $('.filter-actions z, .freseter').css({
            display: 'inline'
        });
        return false;
    }
    return true;
}
;

var loadelements = {
    tickets: false,
    invoices: false,
    services: false,
    accounts: false,
    domains: false,
    clients: false,
    emails: false,
    estimates: false,
    neworder: false,
    loaders: new Array
};


function appendLoader(loadername) {
    loadelements.loaders[loadelements.loaders.length] = loadername;
}

$(window).load(function() {

    function CSRFProtection(xhr) {
        var token = $('meta[name="csrf-token"]').attr('content');
        if (token)
            xhr.setRequestHeader('X-CSRF-Token', token);
    }
    if ('ajaxPrefilter' in $)
        $.ajaxPrefilter(function(options, originalOptions, xhr) {
            CSRFProtection(xhr)
        });
    else
        $(document).ajaxSend(function(e, xhr) {
            CSRFProtection(xhr)
        });

    $('#taskMGR').taskMgr();
    $('#smarts').SmartSearch();

    pops();


    $('.fadvanced').click(function() {
        if ($('#hider').html() == '') {

            ajax_update($(this).attr('href'), {}, '#hider');
            $('#hider2').hide();
            $('#hider').show();
        } else {
            $('#hider').show();
            $('#hider2').hide();
        }
        return false;
    });

    $('a.tload').click(function() {
        if ($(this).hasClass('tstyled')) {
            $('body').find('a.tload').removeClass('selected');
            $(this).addClass('selected');
        }
        window.clearInterval(checkUrlInval);
        window.location.hash = "";
        ajax_update($(this).attr('href'), {}, '#bodycont');

        return false;
    });




    bindEvents();


    var loadelements_cp = loadelements;

    if (loadelements_cp.tickets)
        bindTicketEvents();

    if (loadelements_cp.invoices)
        bindInvoiceEvents();

    if (loadelements_cp.estimates)
        bindEstimatesEvents();

    if (loadelements_cp.services)
        bindServicesEvents();

    if (loadelements_cp.accounts)
        bindAccountEvents();

    if (loadelements_cp.domains)
        bindDomainEvents();
    if (loadelements_cp.clients)
        bindClientEvents();
    if (loadelements_cp.neworder)
        bindNewOrderEvents();

    var l1a = loadelements_cp.loaders;
    var ll = l1a.length;
    if (ll > 0) {
        var i = 0;
        for (i = 0; i < ll; i++)
            eval(l1a[i] + '()');
    }
});

function bindClientEvents() {

    var client_id = $('#client_id', '#bodycont').val();

    $('.clDropdown', '#bodycont').click(function() {
        return false;
    });


    var client = new ZeroClipboard($(".copytext")).on('complete', function(client, args) {
        $(this).html("&#10003;");
    });


    $('#clientform').submit(function() {
        //check if confirmation form needs to be displayed
        if ($('#old_currency_id').val() != $('#currency_id').val()) {
            $('#bodycont').css('position', 'relative');
            $('#confirm_curr_change').width($('#bodycont').width()).height($('#bodycont').height()).show();
            return false;
        }
        return true;
    });


    $('#sendmail').click(function() {
        if ($('#mail_id').val() == 'custom') {
            window.location.href = '?cmd=sendmessage&type=clients&selected=' + $('#client_id').val();
        }
        else {
            $.post('?cmd=clients&action=sendmail', {
                mail_id: $('#mail_id', '#bodycont').val(),
                id: client_id
            }, parse_response);
            return false;
        }

    });
    $('#tdetail a', '#bodycont').click(function() {

        $('.secondtd', '#bodycont').toggle();
        $('.tdetails', '#bodycont').toggle();
        $('.a1', '#tdetail').toggle();
        $('.a2', '#tdetail').toggle();
        return false;
    });
    $('.livemode', '#bodycont').hover(function() {
        $(this).append('<a href="#" onclick="return false;" class="manuedit">' + lang['edit'] + '</a>');
    }, function() {
        $(this).find('.manuedit').remove();
    }).click(function() {
        $('#tdetail a').click();
    });
    $('.clDropdown', '#bodycont').dropdownMenu({}, function(action, el, pos) {
        action = action.substr(action.lastIndexOf('/') + 1);

        if (action == 'OpenTicket') {
            window.location.href = '?cmd=tickets&action=new&client_id=' + client_id;
        } else if (action == 'CreateInvoice') {
            window.location.href = '?cmd=invoices&action=createinvoice&client_id=' + client_id;
        }
        else if (action == 'PlaceOrder') {
            window.location.href = '?cmd=orders&action=add&related_client_id=' + client_id;
        }
        else if (action == 'SendNewPass') {
            ajax_update('?cmd=clients&action=show&make=resetpass&id=' + client_id, false);

        }
        else if (action == 'CloseAccount') {
            $('#bodycont').css('position', 'relative');
            $('#confirm_cacc_close').width($('#bodycont').width()).height($('#bodycont').height()).show();
        } else if (action == 'DeleteAccount') {

            $('#bodycont').css('position', 'relative');
            $('#confirm_cacc_delete').width($('#bodycont').width()).height($('#bodycont').height()).show();


        } else if (action == 'EditNotes') {
            AdminNotes.show();
        } else if (action == 'EnableAffiliate') {
            window.location.href = '?cmd=affiliates&action=activate&client_id=' + client_id;
        } else if (action == 'DeleteContact') {

            if (confirm(lang['deleteprofileheading'])) {
                window.location.href = '?cmd=clients&make=deleteprofile&client_id=' + client_id + '&parent_id=' + $('#parent_id').val();
            }
        } else if (action == 'ConvertToClient') {

            if (confirm(lang['convertclientheading'])) {
                window.location.href = '?cmd=clients&action=convertcontact&client_id=' + client_id;
            }
        }

    });

    setTimeout(function() {
        if ($('#client_id').length > 0 && $('#client_stats').length > 0) {
            ajax_update('?cmd=clients&action=loadstatistics&id=' + $('#client_id', '#bodycont').val(), {}, '#client_stats');
        }
    }, 30);
}
;



function bindServicesEvents() {

    $('.addcustom').click(function() {
        $('#customfield').toggle();
        return false;
    });



    $('.iseditable', '#bodycont').click(function() {
        var p = $(this).parents('.editor-container').eq(0);
        p.find('.editor').show();
        p.find('.org-content').hide();
        $(this).parents('tbody.sectioncontent').find('.sectionhead .savesection').show();
        return false;
    });
}
;

var checkUrlInval = '';

function tload2() {

    var wind = window;
    if (wind.location.hash && wind.location.hash != "#") {

        wind.clearInterval(checkUrlInval);
        wind.location.hash = '';
    }
    ajax_update($(this).attr('href'), {}, '#bodycont');



    if ($(this).attr('rel')) {



        wind.location.hash = $(this).attr('rel').replace(/\s/g, '');

        checkUrlInval = setInterval(function() {
            if (!(wind.location.hash) || (wind.location.hash == "#")) {
                wind.clearInterval(checkUrlInval);
                if ($('#backto').length > 0) {
                    ajax_update($('#backto').attr('href'), {}, '#bodycont');
                }
                wind.location.hash = "";


            }
        }, 200);
    }


    return false;
}
;
function bindPredefinied() {

    $('a.file').unbind('click');
    setTimeout(function() {

        $('.treeview').undelegate('a.folder, .hitarea', 'click').delegate('a.folder, .hitarea', 'click', function() {
            var p = $(this).parent();
            var last = false;
            if (p.hasClass('expandable') || p.hasClass('collapsable')) {
                p.toggleClass('expandable').toggleClass('collapsable');
                p.children('div.hitarea').toggleClass('collapsable-hitarea').toggleClass('expandable-hitarea');
                if (p.hasClass('lastExpandable') || p.hasClass('lastCollapsable')) {
                    last = true;
                    p.toggleClass('lastExpandable').toggleClass('lastCollapsable');
                    p.children('div.hitarea').toggleClass('lastExpandable-hitarea').toggleClass('lastCollapsable-hitarea');
                }
            }
            if (p.hasClass('collapsable')) {
                if ($(this).hasClass('hitarea'))
                    var hrf = $(this).siblings('a').attr('href');
                else
                    var hrf = $(this).attr('href');
                ajax_update(hrf, {}, function(data) {
                    var resp = parse_response(data);
                    $('#' + p.attr('id')).html(resp);
                    if (last)
                        p.children('div.hitarea').addClass('lastCollapsable-hitarea');
                });
            } else {
                p.find('ul').remove();
            }

            return false;
        });

    }, 50);

}
;

function bindFreseter() {

    $('.haspicker').datePicker({
        startDate: startDate
    });
    $('a.freseter', '#content_tb').unbind('click');
    $('a.freseter', '#content_tb').click(function() {
        $('a.freseter').hide();
        $('form.filterform').each(function() {
            this.reset();
        });

        var tv = $('#content_tb');
        if (tv.length) {
            tv.removeClass('searchon');
        }

        if ($('#currentlist').length) {

            ajax_update($('#currentlist').attr('href'), {
                page: (parseInt($('.pagination span.current').eq(0).html()) - 1),
                resetfilter: '1'
            }, '#updater');
            return false;
        }

        return true;
    });
}
;

function lateInvoiceBind() {

    $('.tdetail a').unbind('click').click(function() {

        $('.secondtd').toggle();
        $('.tdetails').toggle();
        $('.a1').toggle();
        $('.a2').toggle();
        return false;
    });
    $('.livemode').unbind('mouseenter mouseleave').hover(function() {
        $(this).append('<a href="#" onclick="return false;" class="manuedit">' + lang['edit'] + '</a>');
    }, function() {
        $(this).find('.manuedit').remove();
    }).unbind('click').click(function() {
        $('.tdetail a').click();
    });

}
;
function invoiceItemsSubmit() {
    var line = $(this).parent().parent();
    var invoice_id = $('#invoice_id').val();
    if ($(line).attr('id')) {
        var lineid = $(line).attr('id').replace("line_", ""),
            linetotal = parseFloat($(line).find('.invqty').eq(0).val()) * parseFloat(line.find('.invamount').eq(0).val());
        line.find('#ltotal_' + lineid).html((Math.round(linetotal * 100) / 100).toFixed(2));
    }
    $.post('?cmd=invoices&action=updatetotals&' + $('#itemsform').serialize(), {
        id: invoice_id
    }, function(data) {
        var resp = parse_response(data);
        if (resp) {
            $('#updatetotals').html(resp);

            ajax_update('?cmd=invoices&action=getdetailsmenu', {
                id: invoice_id
            }, '#detcont');
        }
    });


}
;
function bindInvoiceDetForm() {
    lateInvoiceBind();

    var invoice_id = $('#invoice_id').val();

    $('#paid_invoice_line .savebtn').unbind('click').click(function() {
        var l = $(this).parent().parent();
        l.find('#invoice_number').html(l.find('textarea').val().replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1<br/>$2')).show();
        l.removeClass('editable1').find('.editor-line').hide();
        $.post('?cmd=invoices&action=changething&make=changenumber', {
            id: invoice_id,
            number: l.find('textarea').val()
        }, function(data) {
            parse_response(data);
        });
        return false;
    });

    $('.haspicker').datePicker({
        startDate: startDate
    });
    if ($('#standardinvoice').length) {
        if ($('#standardinvoice').is(':checked')) {
            $('.standardinvoice').show();
            $('.recurringinvoice').hide();
            $('#is_recurring').val(0);
        } else {
            $('.recurringinvoice').show();
            $('.standardinvoice').hide();
            $('#is_recurring').val(1);
        }
    }


    $('.removeTrans').unbind('click');
    $('.removeTrans').click(function() {
        var el = $(this);
        var answer = confirm("Do you really want to delete this transaction?");
        if (answer) {
            $.post($(this).attr('href'), {empty1mc: 'param'}, function(data) {
                var resp = parse_response(data);
                if (resp == true) {
                    el.parent().parent().slideUp('fast', function() {
                        $(this).remove();
                    });
                    $('.invitem').eq(0).change();
                }
            });
        }
        return false;
    });

    $('#catoptions').unbind('change').change(function() {
        if ($(this).val() == '-1') {
            ajax_update('?cmd=invoices&action=getblank', {}, '#products');
            $('#products').show();
            $('#rmliner').hide();
        } else if ($(this).val() == '-2') {
            ajax_update('?cmd=invoices&action=getaddon', {currency_id: $('#currency_id').val()}, '#products');
            $('#products').show();
            $('#rmliner').hide();
        }
        else if ($(this).val() > '0') {
            ajax_update('?cmd=invoices&action=getproduct', {
                cat_id: $(this).val(),
                currency_id: $('#currency_id').val()

            }, '#products');
            $('#products').show();
            $('#rmliner').hide();
        }
    });

    $('#updateclietndetails').unbind('click').click(function() {
        $('a', '.tdetail').eq(0).click();
        ajax_update('?cmd=invoices&action=changething&make=updateclientdetails&id=' + invoice_id);
        ajax_update('?cmd=invoices&action=edit&list=all&id=' + invoice_id, {}, '#bodycont');
    });

    $('#prodcanc').unbind('click');
    $('.prodok').unbind('click').click(function() {
        if ($('#nline').length > 0 && $('#nline').val() != '') {
            var taxa = 0;
            if ($('#nline_tax').is(':checked'))
                taxa = 1;
            $('#main-invoice').addLoader();
            $.post('?cmd=invoices&action=addline', {
                line: $('#nline').val(),
                tax: taxa,
                price: $('#nline_price').val(),
                qty: $('#nline_qty').val(),
                id: invoice_id
            }, function(data) {
                var resp = parse_response(data);
                if (resp) {
                    $('#main-invoice').html(resp);
                    $('#nline').val('');
                    $('#nline_price').val('');
                    $('#nline_tax').removeAttr('checked');
                    //$('#detailsform').eq(0).submit();
                    //would set recurring next_invoice back, after it was updated by addline
                    //invoiceItemsSubmit();
                }
            });
        } else if ($('#product_id').length > 0) {
            $.post('?cmd=invoices&action=addline', {
                product: $('#product_id').val(),
                id: invoice_id
            }, function(data) {
                var resp = parse_response(data);
                if (resp) {
                    $('#main-invoice').html(resp);
                    $('#detailsform').eq(0).submit();
                    //invoiceItemsSubmit();
                }
            });
        } else if ($('#addon_id').length > 0) {
            $('#main-invoice').addLoader();
            $.post('?cmd=invoices&action=addline', {
                addon: $('#addon_id').val(),
                id: invoice_id
            }, function(data) {
                var resp = parse_response(data);
                if (resp) {
                    $('#addliners').before(resp);
                    $('#detailsform').eq(0).submit();
                    //invoiceItemsSubmit();
                }
            });
        }
        $('#prodcanc').click();
    });

    function prodcanc() {
        $('#products').hide();
        $('#products').html('');
        $('#rmliner').show();
        $('#addliners').show();
        $('#catoptions_container').hide();
        $('#addliners2').hide();
        $('#catoptions option').each(function() {
            $(this).removeAttr('selected');
        });
        $('#catoptions option').eq(1).attr('selected', 'selected');
    }
    $('#prodcanc').click(function() {
        prodcanc();
    });
    $('#rmliner').click(function() {
        prodcanc();
    });

}
;

function bindDomainEvents() {
    $('.toLoad').click(function() {

        $('#dommanager').show();
        $('#man_content').html('<center><img src="ajax-loading.gif" /></center>');
        $('#man_title').html($(this).attr('value'));

        $.post('?cmd=domains&action=' + $(this).attr('name'), {
            val: $(this).attr('value'),
            id: $('#domain_id').val(),
            name: $('#domain_name').val()
        }, function(data) {
            $('#man_content').scrollToEl('#man_content');
            var resp = parse_response(data);
            if (resp && resp != '') {
                $('#man_content').html(resp);
            } else
                $('#man_content').html(' ');
        });

        return false;
    });

    $('.livemode').not('tr').hover(function() {
        $(this).append('<a href="#" onclick="return false;" class="manuedit">' + lang['edit'] + '</a>');
    }, function() {
        $(this).find('.manuedit').remove();
    }).not('tr').click(function() {
        if ($('.changeMode').eq(0).is(':checked')) {
            $('.changeMode').removeAttr('checked').eq(0).trigger('change');
        } else {
            $('.changeMode').attr('checked', 'checked').eq(0).trigger('change');
        }
    });


    $('#bodycont .changeMode').change(function() {
        var modes = 0;


        if ($(this).is(':checked')) {
            //manual mode on
            modes = 1;
            $.post('?cmd=domains&action=manualmode', {
                mode: modes,
                id: $('#domain_id').val()
            }, function(data) {
                var resp = parse_response(data);
                if (resp) {

                    $('.changeMode').attr('checked', 'checked');

                    $('.manumode').show();
                    $('.livemode').hide();
                    $('#domainname').removeAttr('readonly');
                    $('#epp_code').show();
                }
            });


        } else {

            $.post('?cmd=domains&action=manualmode', {
                mode: modes,
                id: $('#domain_id').val()
            }, function(data) {
                var resp = parse_response(data);
                if (resp) {

                    $('.changeMode').removeAttr('checked');
                    $('.livemode').show();
                    $('.manumode').hide();

                    $('.pen').hide();
                    $('.nep').show();
                    $('#domainname').attr('readonly', 'readonly');
                    $('#epp_code').hide();
                }
            });



        }
    });
    $('.setStatus', '#bodycont').click(function() {
        return false;
    });
    $('.setStatus', '#bodycont').dropdownMenu({}, function(action, el, pos) {
        action = action.substr(action.lastIndexOf('/') + 1);

        if (action == 'AdminNotes') {
            AdminNotes.show();
        } else if (action == 'ChangeOwner') {

            $('#ChangeOwner').show();
            ajax_update('?cmd=domains&action=getowners', {}, '#ChangeOwner', true);

        }

    });

    $('#sendmail').click(function() {
        if ($('#mail_id').val() == 'custom') {
            window.location.href = '?cmd=sendmessage&type=domains&selected=' + $('#domain_id').val();
        }
        else {
            $.post('?cmd=domains&action=sendmail', {
                mail_id: $('#mail_id').val(),
                id: $('#domain_id').val()
            }, function(data) {
                var resp = parse_response(data);

            });
            return false;
        }

    });
}
;

function bindAccountEvents() {
    $('.toLoad').click(function() {

        $('#dommanager').show();
        $('#man_content').html('<center><img src="ajax-loading.gif" /></center>');
        $('#man_title').html($(this).attr('value'));

        $.post('?cmd=accounts&action=' + $(this).attr('name'), {
            val: $(this).attr('value'),
            id: $('#account_id').val()
        }, function(data) {
            var resp = parse_response(data);
            if (resp && resp != '') {
                $('#man_content').html(resp);
            } else
                $('#man_content').html(' ');
        });

        return false;
    });



    $('.livemode').not('tr').not('input[type=submit]').hover(function() {
        $(this).append('<a href="#" onclick="return false;" class="manuedit">' + lang['edit'] + '</a>');
    }, function() {
        $(this).find('.manuedit').remove();
    }).click(function() {
        if ($('.changeMode').eq(0).is(':checked')) {
            $('#changeMode').removeAttr('checked').eq(0).trigger('change');
        } else {
            $('#changeMode').attr('checked', 'checked').eq(0).trigger('change');
        }
    });

    $('#changeMode').change(function() {
        var modes = 0;


        if ($(this).is(':checked')) {
            //manual mode on
            modes = 1;
            $.post('?cmd=accounts&action=manualmode', {
                mode: modes,
                id: $('#account_id').val()
            }, function(data) {
                var resp = parse_response(data);
                if (resp) {
                    //   if (tv.length>0) {
                    //      tv.addClass('manmode');
                    //  }
                    $('#changeMode').attr('checked', 'checked');
                    //  $('#product_id').removeAttr('disabled');


                    $('.h_manumode').removeAttr('disabled');
                    $('#passchange').show();
                    $('.manumode').show();
                    $('.livemode').hide();

                }
            });


        } else {

            $.post('?cmd=accounts&action=manualmode', {
                mode: modes,
                id: $('#account_id').val()
            }, function(data) {
                var resp = parse_response(data);
                if (resp) {
                    //    if (tv.length>0) {
                    //         tv.removeClass('manmode');
                    //    }
                    $('#changeMode').removeAttr('checked');

                    $('.h_manumode').attr('disabled', 'disabled');
                    $('.livemode').show();
                    $('.manumode').hide();
                    if ($('#product_id option[def]') != undefined)
                        $(':input[id="product_id"]')[0].selectedIndex = $('#product_id option[def]')[0].index;
                    if ($('#server_id option[def]') != undefined)
                        $(':input[id="server_id"]')[0].selectedIndex = $('#server_id option[def]')[0].index;
                }
            });



        }
    });

    $('#product_id').change(function() {
        $.post('?cmd=accounts&action=getservers', {
            server_id: $('#server_id').val(),
            product_id: $(this).val(),
            manumode: $('#server_id').hasClass('manumode') ? '1' : '0',
            show: $('.changeMode').eq(0).is(':checked') ? '1' : '0'
        }, function(data) {
            var resp = parse_response(data);
            if (resp) {
                $('#serversload').html(resp);
            }

        });
        return false;
    });

    $('#sendmail').click(function() {
        if ($('#mail_id').val() == 'custom') {
            window.location.href = '?cmd=sendmessage&type=accounts&selected=' + $('#account_id').val();
        }
        else {
            $.post('?cmd=accounts&action=sendmail', {
                mail_id: $('#mail_id').val(),
                id: $('#account_id').val()
            }, function(data) {
                var resp = parse_response(data);

            });
            return false;
        }

    });

    $('.setStatus').click(function() {
        return false;
    });

    $('.setStatus').dropdownMenu({}, function(action, el, pos) {
        action = action.substr(action.lastIndexOf('/') + 1);

        if (action == 'AdminNotes') {
            AdminNotes.show();
        }
        else if (action == 'ChangeOwner') {

            $('#ChangeOwner').show();
            ajax_update('?cmd=accounts&action=getowners', {}, '#ChangeOwner', true);

        } else if (action == 'Delete') {
            if ($("#testform input[class=check]:checked").length < 1) {
                alert('Nothing checked');
                return false;
            }
            else {
                confirm1();
            }

        }



    });
    if ($('#account_id').length > 0)
        ajax_update('?cmd=accounts&action=getacctaddons', {id: $('#account_id').val()}, '#loadaddons');
}
;

function bindInvoiceEvents() {

    var wind = window;
    if (wind.location.hash != '' && wind.location.hash && wind.location.hash.substr(0, 1) == "#" && $('#invoice_id').length < 1 && wind.location.hash != '#') {
        ajax_update('?cmd=invoices&action=edit&list=all&id=' + window.location.hash.substr(1), {}, '#bodycont');
    }
    var invoice_id = $('#invoice_id').val();



    $('.transeditor').change(function() {
        $.post('?cmd=invoices&action=changething&' + $('#transform').serialize(), {
            id: invoice_id
        }, function(data) {
            var resp = parse_response(data);
            if (resp == true) {

                $('.invitem').eq(0).change();
            }
        });
    });


    $('#new_currency_id').change(function() {
        $('#exrates').find('input').hide();
        $('#exrates').find('input').eq($('#new_currency_id')[0].selectedIndex).show();

    });
    $('#calcex').click(function() {
        if ($(this).is(':checked')) {
            $('#exrates').show();
            $('#exrates').find('input').eq($('#new_currency_id')[0].selectedIndex).show();
        } else {
            $('#exrates').hide();
        }

    });

    //$('div').hide();
    $('#addliner').click(function() {
        $('#addliners2').show();
        $('#catoptions_container').show();
        $('#addliners').hide();
        return false;
    });

    $('a.tload2').click(tload2);

    setTimeout('lateInvoiceBind()', 30);
    setTimeout('bindInvoiceDetForm()', 30);




    $('#inv_notes').bind('change', function() {
        $(this).addClass('notes_changed');
        $('#notes_submit').show();
    });

    $('#notes_submit input').click(function() {
        var note = $('#inv_notes').val();
        $(this).parent().hide();
        $('#inv_notes').removeClass('notes_changed');
        $.post('?cmd=invoices&action=changething&make=addnotes', {
            id: invoice_id,
            notes: note
        }, function(data) {
            parse_response(data);
        });
        return false;
    });

    $('.setStatus').unbind('click').click(function() {
        return false;
    }).dropdownMenu({}, function(action, el, pos, valx) {

        action = action.substr(action.lastIndexOf('/') + 1);

        if (action == 'Paid' || action == 'Unpaid' || action == 'Cancelled' || action == 'Refunded') {
            $.post('?cmd=invoices&action=changething&make=setstatus', {
                status: action,
                id: invoice_id
            }, function(data) {
                var resp = parse_response(data);
                if (resp != false && resp != null) {
                    $('#invoice_status').html(valx);

                    $('#invoice_status').attr({
                        'class': action
                    });
                    $('.addPayment').removeClass('disabled');
                    $('#hd1_m li').removeClass('disabled');
                    $('#hd2_m li').removeClass('disabled');
                    $('li.act_' + action.toLowerCase()).addClass('disabled');

                } else {

                }

            });
        }
        else if (action == 'SplitItems') {
            if ($('.invitem_checker').length < 2 || $('.invitem_checker:checked').length < 1) {
                return;
            }
            // ajax_update('?cmd=invoices&action=edit&list=all&id='+window.location.hash.substr(1),{},'#bodycont');
            var inv = $('.invitem_checker:checked').serialize();
            $.getJSON('?cmd=invoices&action=split&' + inv, {id: invoice_id}, function(data) {
                if (data.id) {
                    $('#taskMGR').taskMgrAddInfo('Invoice split success');
                    ajax_update('?cmd=invoices&action=edit&list=all&id=' + data.id, {}, '#bodycont');
                    window.location.hash = '#' + data.id;
                }
            });
        }
        else if (action == 'AddNote') {
            $('#inv_notes').focus();
        } else if (action == 'SendReminder2') {
            if ($("#testform input[class=check]:checked").length < 1) {
                alert('Nothing checked');
                return false;
            }
            else {
                ajax_update('?cmd=invoices&action=bulkreminder&' + $("#testform").serialize(), {stack: 'push'});
            }
        } else if (action == 'MarkCancelled') {
            $('.markcancelled').eq(0).click();
        } else if (action == 'downloadPDF') {
            wind.location.href = '?action=download&invoice=' + invoice_id;
        } else if (action == 'EditNumber') {
            $('#paid_invoice_line .editbtn').click();

        } else if (action == 'LockInvoice' || action == 'UnlockInvoice') {
            console.log('?cmd=invoices&action=edit&id=GF0A274WAJ');
            wind.location.href = '?cmd=invoices&action=menubutton&id=' + invoice_id
                + '&make=' + (action == 'UnlockInvoice' ? 'unlock' : 'lock')
                + '&security_token=' + $('input[name=security_token]').val();

        } else if (action == 'EditDetails') {
            $('.tdetail a').click();
        } else if (action == 'SendInvoice') {
            $.post('?cmd=invoices&action=changething&make=sendinvoice', {
                id: invoice_id
            }, function(data) {
                parse_response(data);
            });
        } else if (action == 'IssueRefund') {
            $('#refunds').load('?cmd=invoices&action=refundsmenu&invoice_id=' + invoice_id, function(data) {
                $('#refunds').show();
            });
        } else if (action == 'ChangeCurrency') {
            $('#chcurr').toggle();
        } else if (action == 'CreateInvoice') {
            wind.location.href = '?cmd=invoices&action=createinvoice&client_id=' + $('#client_id').val();
        }
        else if (action == 'SendReminder') {
            $.post('?cmd=invoices&action=changething&make=sendreminder', {
                id: invoice_id
            }, function(data) {
                parse_response(data);
            });
        } else if (action == 'SendMessage') {
            wind.location.href = '?cmd=sendmessage&type=invoices&selected=' + invoice_id;
        }

    });

    $('.addPayment').click(function() {
        if (!$(this).hasClass('disabled'))
            $('#addpay').toggle();
        return false;

    });
    $('.recstatus').click(function() {
        if ($(this).hasClass('activated'))
            return false;

        var status = 'Active';
        if ($(this).hasClass('recoff'))
            status = 'Stopped';
        $('.recstatus').removeClass('activated');
        $(this).addClass('activated');
        $.post('?cmd=invoices&action=changething&make=changerecstatus', {
            id: invoice_id,
            recstatus: status
        }, function(data) {
            parse_response(data);
        });
        return false;
    });
    $('.sendInvoice').click(function() {
        $.post('?cmd=invoices&action=changething&make=sendinvoice', {
            id: invoice_id
        }, function(data) {
            parse_response(data);
        });
        return false;
    });
    $('.deleteInvoice').click(function() {
        var answer = confirm("Do you really want to delete this invoice?");
        if (answer) {

            if ($(this).attr('href')) {

                $.post($(this).attr('href'), {empty1mc: 'param'}, function(data) {
                    var resp = parse_response(data);
                    $('#currentpage').eq(0).change();
                });

            } else {

                $.post('?cmd=invoices&action=menubutton&make=deleteinvoice', {
                    id: invoice_id
                }, function(data) {
                    var resp = parse_response(data);
                    if (resp == true) {
                        wind.location.href = '?cmd=clients&action=show&id=' + $('#client_id').val() + '&picked_tab=invoices';
                        //$('#backto').eq(0).trigger('click');
                    }
                });
            }

        }
        return false;
    });
    $('.invoiceUnlock').click(function() {
        var that = this;
        $.post($(this).attr('href'), {empty1mc: 'param'}, function(data) {
            var resp = parse_response(data);
            $('a[href=UnlockInvoice]').attr('href', 'LockInvoice').text('Lock invoice');
            $(that).hide();
        });
        return false;
    });


}
;

function bindNewOrderEvents() {
    $('.inv_gen_check').click(function() {
        if (!$(this).is(':checked')) {
            $('#invsend').removeAttr('checked').attr('disabled', 'disabled');
        } else {
            $('#invsend').removeAttr('disabled');
        }
    });
    $('.get_prod_btn').change(function() {
        var elem = $('#product_id');
        if ($(elem).val() == 'new') {
            window.location = "?cmd=services&action=addproduct";
            $(elem).val(($("select[name='" + $(elem).attr('name') + "'] option:first").val()));
        } else {
            var add = '';
            if ($('#client_id').length > 0) {
                if ($('#client_id').val() == 'new') {
                    window.location = "?cmd=newclient";
                    return;
                }
                add = '&client_id=' + $('#client_id').val();
            }
            $('#prod_loader').show();
            ajax_update('?cmd=orders&action=get_product' + add, {product_id: $('#product_id').val()}, '#product_details');
        }
    });
    $('.new_gat_btn').change(function() {
        if ($(this).val() == 'new') {
            window.location = "?cmd=managemodules&action=payment";
            $(this).val(($("select[name='" + $(this).attr('name') + "'] option:first").val()));
        }
    });
    $('.setStatus').dropdownMenu({}, function(action, el, pos, values) {
        action = action.substr(action.lastIndexOf('/') + 1);
        switch (action) {
            case 'add_discount':
                alert('discount');
                $('.dis_menu_el').addClass('hidden').hide();
                if ($('.aff_menu_el').hasClass('hidden')) {
                    $('.setStatus').hide();
                }
                break;
            case 'assign_aff':
                alert('affiliate');
                $('.aff_menu_el').addClass('hidden').hide();
                if ($('.dis_menu_el').hasClass('hidden')) {
                    $('.setStatus').hide();
                }
                ;
                break;
        }
    });
    $('#extend_notes').click(function() {
        $(this).hide();
        $('textarea[name="order_notes"]').show();
    });
    $('#add_dom_btn').click(function() {
        alert('add another domain');
    });
    bindCheckAvailOrd();
}
;

function bindCheckAvailOrd() {
    $('.check_avail').click(function() {
        $('.avail_result').html('<img src="ajax-loading2.gif" />');
        ajax_update('?cmd=orders&action=whois', {domain: $('#domain_sld').val() + $('#domain_tld').val(), type: $("input[name='domain_action']:checked").val()}, '.avail_result');
    });

}
;


function lateEstimatesBind() {

    $('.tdetail a').unbind('click').click(function() {

        $('.secondtd').toggle();
        $('.tdetails').toggle();
        $('.a1').toggle();
        $('.a2').toggle();
        return false;
    });
    $('.livemode').unbind('mouseenter mouseleave').hover(function() {
        $(this).append('<a href="#" onclick="return false;" class="manuedit">' + lang['edit'] + '</a>');
    }, function() {
        $(this).find('.manuedit').remove();
    }).unbind('click').click(function() {
        $('.tdetail a').click();
    });

}
;
function estimatesItemsSubmit() {
    var line = $(this).parent().parent();
    var lineid = $(line).attr('id').replace("line_", "");
    var estimate_id = $('#estimate_id').val();
    line.find('#ltotal_' + lineid).html((parseFloat($(line).find('.invqty').eq(0).val()) * parseFloat(line.find('.invamount').eq(0).val())).toFixed(2));

    $.post('?cmd=estimates&action=updatetotals&' + $('#itemsform').serialize(), {
        id: estimate_id
    }, function(data) {
        var resp = parse_response(data);
        if (resp) {
            $('#updatetotals').html(resp);

            ajax_update('?cmd=estimates&action=getdetailsmenu', {
                id: estimate_id
            }, '#detcont');
        }
    });


}
;
function bindEstimatesDetForm() {
    lateEstimatesBind();
    var estimate_id = $('#estimate_id').val();
    $('.haspicker').datePicker({
        startDate: startDate
    });


    $('#catoptions').unbind('change').change(function() {
        if ($(this).val() == '-1') {
            ajax_update('?cmd=estimates&action=getblank', {}, '#products');
            $('#products').show();
            $('#rmliner').hide();
        } else if ($(this).val() == '-2') {
            ajax_update('?cmd=estimates&action=getaddon', {currency_id: $('#currency_id').val()}, '#products');
            $('#products').show();
            $('#rmliner').hide();
        }
        else if ($(this).val() > '0') {
            ajax_update('?cmd=estimates&action=getproduct', {
                cat_id: $(this).val(),
                currency_id: $('#currency_id').val()

            }, '#products');
            $('#products').show();
            $('#rmliner').hide();
        }
    });


    $('#prodcanc').unbind('click');
    $('.prodok').unbind('click').click(function() {
        if ($('#nline').length > 0 && $('#nline').val() != '') {
            var taxa = 0;
            if ($('#nline_tax').is(':checked'))
                taxa = 1;
            $('#main-invoice').addLoader();
            $.post('?cmd=estimates&action=addline', {
                line: $('#nline').val(),
                tax: taxa,
                price: $('#nline_price').val(),
                qty: $('#nline_qty').val(),
                id: estimate_id
            }, function(data) {
                var resp = parse_response(data);
                if (resp) {
                    $('#addliners').before(resp);
                    $('#nline').val('');
                    $('#nline_price').val('');
                    $('#nline_tax').removeAttr('checked');
                    $('#detailsform').eq(0).submit();
                }
            });
        } else if ($('#product_id').length > 0) {
            $.post('?cmd=estimates&action=addline', {
                product: $('#product_id').val(),
                id: estimate_id
            }, function(data) {
                var resp = parse_response(data);
                if (resp) {
                    $('#addliners').before(resp);
                    $('#detailsform').eq(0).submit();
                }
            });
        } else if ($('#addon_id').length > 0) {
            $('#main-invoice').addLoader();
            $.post('?cmd=estimates&action=addline', {
                addon: $('#addon_id').val(),
                id: estimate_id
            }, function(data) {
                var resp = parse_response(data);
                if (resp) {
                    $('#addliners').before(resp);
                    $('#detailsform').eq(0).submit();
                }
            });
        }
        $('#prodcanc').click();
    });

    function prodcanc() {
        $('#products').hide();
        $('#products').html('');
        $('#rmliner').show();
        $('#addliners').show();
        $('#catoptions_container').hide();
        $('#addliners2').hide();
        $('#catoptions option').each(function() {
            $(this).removeAttr('selected');
        });
        $('#catoptions option').eq(1).attr('selected', 'selected');
    }
    $('#prodcanc').click(function() {
        prodcanc();
    });
    $('#rmliner').click(function() {
        prodcanc();
    });
}
;


function bindEstimatesEvents() {
    var estimate_id = $('#estimate_id').val();
    $('#estsubject').focus(function() {
        $(this).addClass('sub_hover');

    }).blur(function() {
        $(this).removeClass('sub_hover');

    }).change(function() {
        var note = $(this).val();
        $.post('?cmd=estimates&action=changething&make=addsubject', {
            id: estimate_id,
            subject: note
        }, function(data) {
            parse_response(data);
        });
    });
    $('#changeowner').click(function() {
        $('#curr_det').hide();
        $('#client_container').show();
        ajax_update('?cmd=estimates&action=changeowner&client_id=' + $('#client_id').val() + '&estimate_id=' + estimate_id, false, '#client_container');
        return false;
    });

    $('#new_estimate_button').click(function() {
        if ($('#new_estimate').hasClass('shown')) {
            $('#new_estimate').hide().removeClass('shown');
        } else if ($('#new_estimate').hasClass('content_loaded')) {
            $('#new_estimate').show().addClass('shown');
        } else {
            $('#new_estimate').show().addClass('shown');
            ajax_update('?cmd=estimates&action=getclients', {}, '#new_estimate', true);
            $('#new_estimate').addClass('content_loaded');
        }
    });

    $('#est_notes').bind('textchange', function() {
        $(this).addClass('notes_changed');
        $('#notes_submit').show();
    });
    $('#est_admin_notes').bind('textchange', function() {
        $(this).addClass('notes_changed');
        $('#admin_notes_submit').show();
    });
    $('#notes_submit input').click(function() {
        var note = $('#est_notes').val();
        $(this).parent().hide();
        $('#est_notes').removeClass('notes_changed');
        $.post('?cmd=estimates&action=changething&make=addnotes', {
            id: estimate_id,
            notes: note
        }, function(data) {
            parse_response(data);
        });
        return false;
    });
    $('#admin_notes_submit input').click(function() {
        var note = $('#est_admin_notes').val();
        $(this).parent().hide();
        $('#est_admin_notes').removeClass('notes_changed');
        $.post('?cmd=estimates&action=changething&make=addprivatenotes', {
            id: estimate_id,
            notes_private: note
        }, function(data) {
            parse_response(data);
        });
        return false;
    });
    $('.sendEstimate').click(function() {
        $.post('?cmd=estimates&action=changething&make=sendestimate', {
            id: estimate_id
        }, function(data) {
            parse_response(data);
            $('#hd1_m li').removeClass('disabled');
            $('li.act_sent').addClass('disabled');
            $('#estimate_status').html($('li.act_sent a').html());
            $('#estimate_status').attr({
                'class': 'Sent'
            });
        });

    });
    $('.setStatus').dropdownMenu({}, function(action, el, pos, values) {

        action = action.substr(action.lastIndexOf('/') + 1);

        if (action == 'Draft' || action == 'Sent' || action == 'Accepted' || action == 'Invoiced' || action == 'Dead') {
            $.post('?cmd=estimates&action=changething&make=setstatus', {
                status: action,
                id: estimate_id
            }, function(data) {
                var resp = parse_response(data);
                if (resp != false && resp != null) {
                    if (action == 'Invoiced') {
                        $('button.invoiced_').attr('disabled', 'disabled');
                        $('.invoiced_').addClass('disabled');
                    } else {
                        $('button.invoiced_').removeAttr('disabled');
                        $('.invoiced_').removeClass('disabled');
                    }

                    $('#estimate_status').html(values);
                    $('#estimate_status').attr({
                        'class': action
                    });

                    $('#hd1_m li').removeClass('disabled');

                    $('li.act_' + action.toLowerCase()).addClass('disabled');
                    if (action == 'Dead' || action == 'Draft') {
                        $('#clientlink').hide();
                    } else {
                        $('#clientlink').ShowNicely();
                    }

                } else {

                }

            });
        }
        else if (action == 'AddNote') {
            $('#est_notes').focus();
        } else if (action == 'AddPrivateNote') {
            $('#est_admin_notes').focus();
        } else if (action == 'EditDetails') {
            $('.tdetail a').click();
        } else if (action == 'CreateInvoice') {
            $.post('?cmd=estimates&action=createinvoice', {
                id: estimate_id
            }, function(data) {
                parse_response(data);
            });

        } else if (action == 'downloadPDF') {
            window.location.href = '?action=download&estimate=' + estimate_id;
        } else if (action == 'ChangeCurrency') {
            $('#chcurr').toggle();

        } else if (action == 'CreateInvoice') {
            window.location.href = '?cmd=estimates&action=edit&make=createinvoice&id=' + estimate_id;
        }


    });
    $('#new_currency_id').change(function() {
        $('#exrates').find('input').hide();
        $('#exrates').find('input').eq($('#new_currency_id')[0].selectedIndex).show();

    });
    $('#calcex').click(function() {
        if ($(this).is(':checked')) {
            $('#exrates').show();
            $('#exrates').find('input').eq($('#new_currency_id')[0].selectedIndex).show();
        } else {
            $('#exrates').hide();
        }

    });
    $('#addliner').click(function() {
        $('#addliners2').show();
        $('#catoptions_container').show();
        $('#addliners').hide();
        return false;
    });
    $('.deleteEstimate').click(function() {
        var answer = confirm("Do you really want to delete this estimate?");
        if (answer) {

            if ($(this).attr('href')) {
                // alert($(this).attr('href'));
                $.post($(this).attr('href'), {empty1mc: 'param'}, function(data) {
                    var resp = parse_response(data);
                    $('#currentpage').eq(0).change();
                });

            } else {

                $.post('?cmd=estimates&action=menubutton&make=deleteestimate', {
                    id: estimate_id
                }, function(data) {
                    var resp = parse_response(data);
                    if (resp == true) {
                        window.location.href = '?cmd=clients&action=show&id=' + $('#client_id').val() + '&picked_tab=estimates';
                        //$('#backto').eq(0).trigger('click');
                    }
                });
            }

        }
        return false;
    });
    $('.tdetail a').unbind('click').click(function() {

        $('.secondtd').toggle();
        $('.tdetails').toggle();
        $('.a1').toggle();
        $('.a2').toggle();
        return false;
    });
    $('.livemode').unbind('mouseenter mouseleave').hover(function() {
        $(this).append('<a href="#" onclick="return false;" class="manuedit">' + lang['edit'] + '</a>');
    }, function() {
        $(this).find('.manuedit').remove();
    }).unbind('click').click(function() {
        $('.tdetail a').click();
    });
    bindEstimatesDetForm();
}

//var autodraft=false;
function bindTicketEvents() {

    var ticket_num = $('#ticket_number').val();
    var wind = window;
    var doc = document;
    var backref = $('#backredirect').val();
    ticket.initPoll();
    // unbind/pause poll
    $('#ticketsubmitter').click(function() {
        ticket.autopoll = false;
    });

    $('#showlatestreply').click(function() {
        var ttime = '';
        if ($(this).attr('rel')) {
            ttime = $(this).attr('rel');
            $(this).removeAttr('rel');
        } else {
            ttime = $('#recentreplies input.viewtime:last').val();
        }
        ajax_update('?cmd=tickets', {action: 'menubutton', make: 'getrecent', viewtime: ttime, id: $('#ticket_number').val()}, '#recentreplies', false, true);
        $('#justadded').hide();
        return false;
    });
    if (wind.location.hash != '' && wind.location.hash && wind.location.hash.substr(0, 1) == "#" && $('#ticket_id').length < 1 && wind.location.hash != '#') {
        ajax_update('?cmd=tickets&action=view&list=all&num=' + window.location.hash.substr(1), {brc: backref}, '#bodycont');
    }
    $('.scroller').click(function() {
        var $target = $('[name=' + $(this).attr('href').substr(1) + ']');
        if ($target.length) {
            var targetOffset = $target.offset().top;
            $('html,body').animate({
                scrollTop: targetOffset - 100
            }, 500, 'linear', function() {
                $('#replyarea').focus();
            });
            return false;
        }
    });


    $('#replyarea').keydown(function() {
        if (!$('#draftinfo .controls').is(':visible') && $('#replyarea').val() != '') {
            $('#draftinfo .controls').show();
            $('#draftinfo .draftdate').show();
        }
        /*
         if(autodraft===false) {
         autodraft = setInterval(function(){
         if($('#replyarea').length>0 && $('#replyarea').val()!='')
         ajax_update('?cmd=tickets',{make:'savedraft',action:'menubutton',id:ticket_num,body:$('#replyarea').val()},'#draftinfo .draftdate');
         
         }, 10000);
         }
         */
    });

    function bindTicketNoteRemove() {
        if ($('.ticketnotesremove').length < 2) {
            $('#ticketnotebox').slideUp();
            $('.badd').show();
        }
        $(this).parents('tr').eq(0).hide();
        ajax_update('?cmd=tickets', {make: 'removenote', action: 'menubutton', id: ticket_num, noteid: this.hash.slice(1)}, function(data) {
            $('#ticketnotes').html(data);
            $('.ticketnotesremove').bind('click', bindTicketNoteRemove);
        });

        return false;
    }
    $('#ticketnotessave').click(function() {
        var data = $('input,textarea', '.admin-note-new').serializeObject();
        data.make = 'savenotes';
        data.action = 'menubutton';
        data.id = ticket_num;

        ajax_update('?cmd=tickets', data, function(data) {
            $('#ticketnotes').html(data);
            $('.ticketnotesremove').bind('click', bindTicketNoteRemove);
        });
        $('#ticketnotesarea').val('');
        return false;
    });

    $('#ticketnotesfile').click(function() {
        var resultlist = {},
            place = $('<div class="result"><input type="file" data-upload="?cmd=downloads&action=upload" /></div>').appendTo('.admin-note-new .admin-note-attach')
            .bind('fileuploadsend', function(e, data) {
                place.children().hide();
                for (var i in data.files) {
                    resultlist[i] = $('<div class="upload-result"><a class="attachment" >' + data.files[i].name + '</a> <span class="ui-autocomplete-loading" style="padding: 10px;"></span></div>').appendTo(place);
                }
            })
            .bind('fileuploadalways', function(e, data) {
                place.children('input').remove();
                for (var i in data.result) {
                    if (resultlist[i]) {
                        var r = resultlist[i];
                        r.children('span').remove();
                        if (data.result[i].error)
                            r.append('<span>' + data.result[i].error + '</span>');
                        else {
                            r.append('<input name="attachments[]" value="' + data.result[i].hash + '" type="hidden"/>');
                            $('<a href="#" class="editbtn"></a>').append('<small>&#91;Remove&#93;</small>').appendTo(r).click(function() {
                                $.post(data.result[i].delete_url);
                                r.remove();
                                return false;
                            });
                        }
                    }
                }
                //place.children().remove().text(data.result);
            });
        fileupload_init();
        return false;
    });
    if (ticket_num) {
        ajax_update('?cmd=tickets', {action: 'menubutton', make: 'loadnotes', id: ticket_num}, function(data) {
            $('#ticketnotes').html(data);
            $('.ticketnotesremove').bind('click', bindTicketNoteRemove);
        });
    }
    // MOVE TO TICKETS

    $('.attach').click(function() {
        $('#attachments').show();
        $('#attachments').append('<br/><input type="file" size="50" name="attachments[]" class="attachment"/>');
        return false;
    });
    $('.deleteTicket').click(function() {
        var answer = confirm("Do you really want to delete this ticket?");
        if (answer) {
            $.post('?cmd=tickets&action=menubutton&make=deleteticket', {
                tnum: ticket_num
            }, function(data) {
                var resp = parse_response(data);
                if (resp == true) {
                    $('.tload.selected').trigger('click');
                }
            });

        }
        return false;
    });

    $('.deletereply').click(function() {
        var answer = confirm("Do you really want to delete this reply?");
        var rin = $(this).attr('href').substr($(this).attr('href').lastIndexOf('/') + 1);
        if (answer) {
            $.post('?cmd=tickets&action=menubutton&make=deletereply', {
                rid: rin,
                tnum: ticket_num
            }, function(data) {
                var resp = parse_response(data);
                if (resp == true) {
                    $('#reply_' + rin).slideUp('slow', function() {
                        $(this).remove()
                    });
                }
            });
        }
        return false;
    });

    $('#ticket_editform').submit(function(event) {
        event.preventDefault();
        var form = this;
        $.post('?cmd=tickets&' + $(this).serialize(), {}, function(data) {
            var resp = parse_response(data);
            if (resp == true) {
                $('#ticket_editdetails').hide();
                ajax_update($(form).attr('action'), {brc: backref}, '#bodycont');
                ;
            }
        });
        return false;
    });

    $('a.editTicket').click(function(event) {
        event.preventDefault();
        var op = [400, 260];
        if ($('.tdetails').data('cls'))
            op = [230, ''];
        $('.tdetails tr').show();
        $('.tdetails').animate({width: op[0]}, {queue: true}).data('cls', op[0] == 400).find('input[name], select[name]').each(function() {
            var self = $(this);
            self.unbind('.edit').bind('change.edit', function() {
                if (self.is('select'))
                    self.prev().text(self.children('[value="' + self.val() + '"]').text());
                else
                    self.prev().text(self.val());
            })
            self.parents('td').eq(0).children(':first').toggle().siblings().toggle();
            var val = $(this).val();
            if (self.parents('.sh_row').length && (!val.length || (self.is('select') && (val == '0' || val == 0)))) {
                self.parents('.sh_row').hide();
            }
        });
        if (op[0] == 400)
            $('.tdetails tr').show();
        else {
            $('.tdetails tr.sh_row.force').hide();
            var data = $('input[name], select[name], textarea[name], button[name]', '.tdetails').serializeObject();
            data.action = 'menubutton';
            data.make = 'edit_ticket';
            data.ticket_number = ticket_num;


            $.post('?cmd=tickets', data, function(data) {
                $.post('?cmd=tickets&action=view&list=all&num=' + ticket_num, {brc: backref}, function(data) {
                    var reply = $('#replyarea').val();
                    data = parse_response(data);
                    if (data) {
                        $('#bodycont').html($(data).find('#replyarea').val(reply).end());
                    }
                });
            });
        }
        $('.tdetails table tr:first td:last').animate({'width': op[1]}, {queue: true});
    });

    $('a.editor').click(function(event) {
        event.preventDefault();
        var id = $(this).attr('href');
        if (typeof id == undefined || id == '#')
            id = '';
        var elem = $(this).parents('.ticketmsg');
        $.post('?cmd=tickets&action=menubutton&make=getreply', {rid: id == '' ? $('#ticket_id').val() : id, rtype: id == '' ? 'ticket' : 'reply'}, function(data) {
            if (typeof data.reply != undefined)
                var h = $('#msgbody' + id, elem).height();
            $('#editbody' + id, elem).show().children('textarea').height(h).val(data.reply).elastic();
            $('#msgbody' + id, elem).hide();
            $('.editbytext', elem).hide();
        });
        return false;
    });

    $('a.editorsubmit').click(function(event) {
        event.preventDefault();
        var id = $(this).attr('href');
        if (typeof id == undefined || id == '#')
            id = '';
        var elem = $(this).parents('.ticketmsg');
        $.post('?cmd=tickets&action=menubutton&make=editreply', {rid: id == '' ? $('#ticket_id').val() : id, rtype: id == '' ? 'ticket' : 'reply', body: $('#editbody' + id, elem).children('textarea').val()}, function(data) {
            var resp = parse_response(data);
            var h = $('#msgbody' + id, elem).replaceWith(resp).show();
            $('#editbody' + id, elem).hide();
        });
        return false;
    });

    $('.quoter').click(function() {
        var type = 'reply';
        if ($(this).attr('type') != 'reply') {
            type = 'ticket';
        }
        var ribd = $(this).attr('href').substr($(this).attr('href').lastIndexOf('/') + 1);
        $.post('?cmd=tickets&action=menubutton&make=quote', {
            rid: ribd,
            rtype: type
        }, function(data) {
            var resp = parse_response(data);
            if (typeof (resp) == 'string') {
                var reply = $('#replyarea').val();
                $('#replyarea').val(reply + "\r\n" + resp);
                $('.scroller').trigger('click');
            }

        });
        return false;
    });

    $('.tdetail a').click(function() {
        $('.tdetails').toggle();
        $('.a1').toggle();
        $('.a2').toggle();
        return false;
    });
    $('.ticketmsg').mouseup(function() {
        var sel = (doc.selection) ? doc.selection.createRange().text : doc.getSelection();
        if (sel != '') {
            $(this).find('.quoter2').show();
        } else {
            $(this).find('.quoter2').hide();
        }
    });
    $('.quoter2').click(function() {
        var sel = (doc.selection) ? doc.selection.createRange().text : doc.getSelection().toString();
        var reply = $('#replyarea').val();
        $('#replyarea').val(reply + "\r\n>" + sel.replace(/\n/g, "\n>") + "\r\n");
        $('.scroller').trigger('click');
        return false;
    });

    $('.setStatus').dropdownMenu({}, function(action, el, pos, valx) {
        action = action.substr(action.lastIndexOf('/') + 1);

        if (action.lastIndexOf('status|') != -1) {
            action = action.substr(action.lastIndexOf('|') + 1);
            $.post('?cmd=tickets&action=menubutton&make=setstatus', {
                status: action,
                id: ticket_num
            }, function(data) {
                var resp = parse_response(data);
                if (resp != false && resp != null) {
                    $('#ticket_status').html(valx);

                    $('#ticket_status').attr({
                        'class': action
                    });

                    $('#hd1_m li').removeClass('disabled');


                    $('li.act_' + action.toLowerCase()).addClass('disabled');
                    if (action == 'Closed') {
                        $('#replytable').hide();
                        $('#backto').click();
                    }
                    else {
                        $('#replytable').show();
                    }
                } else {

                }

            });
        } else if (action == 'Low' || action == 'Medium' || action == 'High') {
            $.post('?cmd=tickets&action=menubutton&make=setpriority', {
                priority: action,
                id: ticket_num
            }, function(data) {
                var resp = parse_response(data);
                if (resp != false && resp != null) {
                    // $('.prior_shelf').attr('class','blu prior_shelf bg_'+action);

                    $('#hd4_m li').removeClass('disabled');
                    $('#ticket_status').parent().attr('class', '').addClass('prior_' + action);


                    $('li.opt_' + action.toLowerCase()).addClass('disabled');

                } else {

                }

            });
        }
        else if (action == 'Unread') {
            ajax_update('?cmd=tickets&action=menubutton&make=markunread', {
                id: ticket_num
            });
        } else if (action == 'ShowLog') {
            ajax_update('?cmd=tickets&action=menubutton&make=showlog', {
                id: $('#ticket_id').val()
            }, '#ticket_log');
            $('#ticket_log').show();
            $('#ticket_editdetails').hide();
        } else if (action == 'blockBody') {
            var sel = (doc.selection) ? doc.selection.createRange().text : doc.getSelection().toString();
            ajax_update('?cmd=tickets&action=menubutton&make=addban', {
                tnum: ticket_num,
                type: 'body',
                text: sel
            });
        } else if (action == 'blockEmail') {
            ajax_update('?cmd=tickets&action=menubutton&make=addban', {
                tnum: ticket_num,
                type: 'email'
            });
        } else if (action == 'blockSubject') {
            ajax_update('?cmd=tickets&action=menubutton&make=addban', {
                tnum: ticket_num,
                type: 'subject'
            });

        } else if (action.substr(0, 6) == 'share:') {
            $.post('?cmd=tickets&action=menubutton&make=share', {
                tnum: ticket_num,
                uuid: action.substr(6)
            }, function(data) {
                parse_response(data);
                ajax_update('?cmd=tickets&action=view&list=all&num=' + ticket_num, {brc: backref}, '#bodycont');
                return false;
            });
        } else if (action == 'unshare') {
            $.post('?cmd=tickets&action=menubutton&make=unshare', {
                tnum: ticket_num
            }, function(data) {
                //console.log(typeof data.tags);
                ajax_update('?cmd=tickets&action=view&list=all&num=' + ticket_num, {brc: backref}, '#bodycont');
            });
        } else if (action.substr(0, 7) == 'assign:' || action.substr(0, 7) == 'subscr:') {
            $.post('?cmd=tickets&action=menubutton&make=assign', {
                tnum: ticket_num,
                id: action.substr(7)
            }, function(data) {
                parse_response(data);
                ajax_update('?cmd=tickets&action=view&list=all&num=' + ticket_num, {brc: backref}, function(data) {
                    var forms = $('textarea, select, input[type!=hidden]', '#replytable form').serializeObject();
                    $('#bodycont').html(parse_response(data));
                    $.each(forms, function(key) {
                        var f = $('[name=' + key + ']', '#replytable form');
                        if (f.is('[type=checkbox]')) {
                            f.prop('checked', this.toString() == 'on')
                        } else
                            f.val(this.toString());
                    })
                });
                return false;
            });
        }

    });

    $('#bodycont').off('click', 'a.tload2').on('click', 'a.tload2', tload2);

    $(doc).mouseup(function() {

        var sel = (doc.selection) ? doc.selection.createRange().text : doc.getSelection();
        if (sel != '') {
            $('.highlighter').removeClass('disabled');
        } else {
            $('.highlighter').addClass('disabled');
            $('.quoter2').hide()
        }

    });

    $('#client_picker').change(function() {
        $(this).removeClass('err');

        if ($(this).val() >= 0) {
            $('#emailrow').hide();
            $('#emailrow2').hide();

        } else if ($(this).val() < 0) {
            $('#emailrow').show();
            $('#emailrow2').show();
        }
    });
    $('#newticketform').submit(function() {
        if ($('#client_picker').val() == '0') {
            $('#client_picker').addClass('err');
            return false;
        } else {
            //	if ($('.attachment').length)
            //		$('#dummy').screenBlock();
            return true;
        }
    });

    var x = $('.ticketmsg:gt(0)').not(':last');
    if (x.length > 3) {
        var d = $('<div class="ticketmsg tmsgwarn"><h2>Click here to show (' + x.length + ') other messages</h2></div>').click(function() {
            $('.ticketmsg:hidden').show();
            $(this).remove();
        });
        x.hide().eq(0).before(d);
    }

    if (ticket_num == parseInt(ticket_num))
        $(document).trigger('HostBill.ticketload');

}
;

function checkEl() {
    var p = $(this).parent().parent();
    if ($(this).is(':checked')) {
        p.addClass('checkedRow');
    } else {
        p.removeClass('checkedRow');
    }

}
;



function bindEvents(repeat) {


    if (typeof (repeat) != 'undefined') {

    } else {
        $(document).pjax('a[data-pjax]', '#bodycont', {timeout: 800}).on('pjax:send', function() {
            $('#taskMGR').taskQuickLoadShow();
        }).on('pjax:complete', function() {
            $('#taskMGR').taskQuickLoadHide();
            bindEvents(true);
        });
    }

    $('.leftNav', '#body-content').on('click', 'a[data-pjax].tstyled', function() {
        $('.leftNav a', '#body-content').removeClass('selected');
        $(this).addClass('selected');
    });

    bindFreseter();
    $('#updater').on('click', '.check', checkEl);
    $("a.vtip_description").vTip();

    $('.hpLinks').dropdownMenu({
        movement: 5
    }, function(action) {
        window.location = action;
    });
    $('.linkDirectly').click(function() {
        window.location = $(this).attr('href');
        return false;

    });

    $('.havecontrols').hover(function() {
        $(this).find('.controls').show();
    }, function() {
        $(this).find('.controls').hide();
    });

    $("a.sortorder").click(function() {
        $('#updater').addLoader();
        $('a.sortorder').removeClass('asc');
        $('a.sortorder').removeClass('desc');
        $('#checkall').attr('checked', false);
        $('#currentlist').attr('href', $(this).attr('href'));

        if ($(this).attr('href').substring($(this).attr('href').lastIndexOf('|')) == '|ASC') {
            $(this).addClass('asc');
            $(this).attr('href', $(this).attr('href').substring(0, $(this).attr('href').lastIndexOf('|')) + '|DESC');
        }
        else {
            $(this).addClass('desc');
            $(this).attr('href', $(this).attr('href').substring(0, $(this).attr('href').lastIndexOf('|')) + '|ASC');
        }

        $.post($('#currentlist').attr('href'), {page: (parseInt($('.pagination span.current').eq(0).html()) - 1)}, function(data) {
            var resp = parse_response(data);
            if (resp) {
                $('#updater').html(resp);
                $('.check').unbind('click').click(checkEl);
            }
        });

        return false;
    });
    $('#checkall').click(function() {
        if ($(this).is(':checked')) {
            $('.check').attr('checked', true).parent().parent().addClass('checkedRow');
            //  $('.check').click();
        } else {
            $('.check').attr('checked', false).parent().parent().removeClass('checkedRow');
            //  $('.check').click();
        }
    });

    $('div.pagination').pagination($('#totalpages').val());

    $('.confirm_it').click(function() {
        if (!confirm('Are you sure you want to perform this action?'))
            return false;
    });

    $('.submiter').click(function() {
        if ($(this).hasClass('confirm')) {
            if (!confirm('Are you sure you want to perform this action?'))
                return false;
        }
        if (!$(this).hasClass('formsubmit')) {
            $('#updater').addLoader();
        }
        $('#checkall').removeAttr('checked').prop('checked', false);
        var pushs = '';
        if ($(this).attr('queue') == 'push')
            pushs = 'push';

        var page = '';
        if ($('.pagination span.current').length > 0)
            page = "&page=" + (parseInt($('.pagination span.current').eq(0).html()) - 1) + '';
        //  ajax_update($('#currentlist').attr('href')+'&'+$('#testform').serialize()+'&'+$(this).attr('name'),{
        //     stack:pushs
        //   },'#updater',false);

        if ($(this).hasClass('formsubmit')) {
            window.location = $('#currentlist').attr('href') + page + '&' + $('#testform').serialize() + '&' + $(this).attr('name');
            return false;
        }

        $.post($('#currentlist').attr('href') + page + '&' + $('#testform').serialize() + '&' + $(this).attr('name'), {
            stack: pushs
        }, function(data) {
            var resp = parse_response(data);
            if (resp) {
                $('#updater').html(resp);
                //$('.check').unbind('click').click(checkEl);
            }
        });

        return false;
    });



    $('a.nav_el').each(function(n) {
        $(this).click(function() {
            if ($(this).hasClass('direct'))
                return true;
            if ($(this).hasClass('nav_sel')) {
                $(this).removeClass('nav_sel').removeClass('minim');
                $('a.nav_el').eq(0).addClass('nav_sel');
                $('div.slide').eq(n).hide();
                $('div.slide').eq(0).show();

                return false;
            }

            $('#client_tab').find('div.slide').hide();

            var sht = $('#client_tab').find('div.slide').eq(n);
            if ($(sht).html() != 'Loading') {
                $(sht).show();

            } else {
                //ajax load

                ajax_update($(this).attr('href'), {}, 'div.slide:eq(' + n + ')');
                $(sht).show();


            }
            $('a.nav_el').removeClass('nav_sel').removeClass('minim');
            $(this).addClass('nav_sel');
            if (n > 0)
                $(this).addClass('minim');
            return false;
        });

    });
    $('[load]').each(function(i) {
        var el = $(this);
        if (el.data('loaded'))
            return false;
        if (el.attr('load') == 'clients') {
            Chosen.find();
            return false;
        }
        if (el.is('select')) {
            var child = $('<option class="search_loading" style="padding:0 0 0 20px"> Loading</option>').appendTo(this);
        }
        $.get(el.attr('load'), function(data) {
            el.data('loaded', true).append(data);
            if (child !== undefined)
                child.remove();
        })
    })
}
;



function bindQConfigEvents() {
    $('#change_pass').click(function() {
        var password1 = $(this).parents('form').find("input[name='password1']").val();
        var password2 = $(this).parents('form').find("input[name='password2']").val();
        $('#qc_update').addLoader();
        ajax_update('?action=saveqc&make=changepass', {password1: password1, password2: password2, qc_page: 'Admin_Pass'}, '#qc_update');

    });

    $('.activate_item').click(function() {
        var type = $(this).parent().find("input[name='type']").val();
        if (type == 'Payment' || type == 'Hosting' || type == 'Domain') {
            $('#qc_update').addLoader();
            var filename = $(this).parent().find("select[name='modulename']").val();
            ajax_update('?action=saveqc&make=activate', {filename: filename, type: type, qc_page: type}, '#qc_update');
        } else if (type == 'Servers') {
            $('#qc_update').addLoader();
            var servername = $(this).parent().find("input[name='name']").val();
            ajax_update('?action=saveqc&make=addserver', {name: servername, qc_page: 'Servers'}, '#qc_update');
        }

    });

    $('.getconfig').click(function() {
        var id = $(this).parents('form').find("input[name='id']").val();
        var type = $(this).parents('form').find("input[name='type']").val();
        if (type == 'Payment')
            var name = '.payconfig_' + id;
        else if (type == 'Domain')
            name = '.domconfig_' + id;
        else if (type == 'Servers')
            name = '.srvconfig_' + id;
        else
            return false;

        if ($(name).hasClass('shown')) {
            $(this).html('Show Config');
            $(name).hide();
            $(name).removeClass('shown');
        } else {
            $(this).html('Hide Config');
            $(name).show();
            $(name).addClass('shown');
        }
        return false;

    });

    $('.deactivatemod').click(function() {
        var id = $(this).parents('form').find("input[name='id']").val();
        var type = $(this).parents('form').find("input[name='type']").val();
        $('#qc_update').addLoader();
        ajax_update('?action=saveqc&make=deactivate', {id: id, qc_page: type}, '#qc_update');
    });

    $('.savemod').click(function() {
        var id = $(this).parents('form').find("input[name='id']").val();
        var type = $(this).parents('form').find("input[name='type']").val();
        var config = $(this).parents('form').serialize();
        $('#qc_update').addLoader();
        ajax_update('?action=saveqc&make=savemodule&' + config, {id: id, qc_page: type}, '#qc_update');
    });

    $('.saveserver').click(function() {
        var id = $(this).parents('form').find("input[name='id']").val();
        var config = $(this).parents('form').serialize();
        $('#qc_update').addLoader();
        ajax_update('?action=saveqc&make=saveserver&' + config, {id: id, qc_page: 'Servers'}, '#qc_update');
    });

    $('.removeserver').click(function() {
        var id = $(this).parents('form').find("input[name='id']").val();
        if (confirm('Do You really want to remove this server?')) {
            $('#qc_update').addLoader();
            ajax_update('?action=saveqc&make=removeserver', {id: id, qc_page: 'Servers'}, '#qc_update');
        }
    });
}
var HBInputTranslate = {};
HBInputTranslate.addTranslation = function(id) {
    $.getJSON('?cmd=langedit', {action: 'quicktag'}, function(data) {
        
        var x = $('#' + id);
        console.log(id, x, x.data('ace'), x.data('aceeditor'))
        if (x.is('input')) {
            var v = x.val();
            x.val(v + "" + data.taglink);
        } else {
            if (x.hasClass('tinyApplied')) {
                x.tinymce().execCommand('mceInsertContent', false, data.taglink);
            }if (x.data('ace')) {
                x.data('aceeditor').getSession().setValue(x.data('aceeditor').getSession().getValue() + data.taglink);
            }else {
                var v = x.val();
                x.val(v + "" + data.taglink);
            }
        }

        $('#l_editor_' + id + ' .translations').append('<a href="?cmd=langedit&action=bulktranslate&key=' + data.tag + '" target="_blank">' + data.taglink + '</a>');
        $('#l_editor_' + id + ' .translations .taag').show();
    });
    return false;
};
HBInputTranslate.tinyMCEFull = {
    theme: "advanced",
    plugins: "pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras",
    theme_advanced_buttons1: "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,formatselect,fontselect,fontsizeselect",
    theme_advanced_buttons2: "cut,copy,paste,pastetext,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
    theme_advanced_buttons3: "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,fullscreen",
    theme_advanced_buttons4: "insertlayer,moveforward,movebackward,absolute,|,styleprops|,visualchars,nonbreaking",
    theme_advanced_toolbar_location: "top",
    theme_advanced_toolbar_align: "left",
    theme_advanced_statusbar_location: "bottom",
    skin: "o2k7",
    skin_variant: "silver",
    theme_advanced_resizing: true,
    convert_urls: false,
    add_form_submit_trigger: false,
    setup: function(ed) { //fix texteare content beeing replaced by content from hidden editor
        ed.onSubmit.add(function(ed, ev) {
            if (!ed.isHidden() && ed.isDirty())
                ed.save();
        });
    }
};
HBInputTranslate.tinyMCESimple = {
    theme: "advanced",
    theme_advanced_buttons1: "bold,italic,underline,separator,strikethrough,justifyleft,justifycenter,justifyright,justifyfull,bullist,numlist,undo,redo,link,unlink,code",
    theme_advanced_buttons2: "",
    skin: "o2k7",
    skin_variant: "silver",
    theme_advanced_buttons3: "",
    theme_advanced_toolbar_location: "top",
    theme_advanced_toolbar_align: "left",
    theme_advanced_statusbar_location: "bottom",
    add_form_submit_trigger: false,
    setup: function(ed) {
        ed.onSubmit.add(function(ed, ev) {
            if (!ed.isHidden() && ed.isDirty())
                ed.save();
        });
    }
};
HBInputTranslate.editorOff = function(el, target) {
//check if editor was applied
    target = $('#' + target);
    $(el).parents('ul').eq(0).find('li').removeClass('active');
    $(el).parent('li').addClass('active');
    if (!target.hasClass('tinyApplied'))
        return false;

    target.tinymce().save();
    target.tinymce().hide();
    return false;
};
HBInputTranslate.editorOn = function(el, target, featureset) {
    target = $('#' + target);
    $(el).parents('ul').eq(0).find('li').removeClass('active');
    $(el).parent('li').addClass('active');
    if (!target.hasClass('tinyApplied')) {
        var f = HBInputTranslate.tinyMCESimple;
        if (featureset && typeof (featureset) != 'string') {
            f = featureset;
        }

        target.addClass('tinyApplied').tinymce(f)
    } else {
        //just toggle editor on
        target.addClass('tinyApplied').tinymce().show();
    }
    return false;

};

HBInputTranslate.aceOn = function(el, target) {
    var textarea = $('#' + target),
        editor = $('#' + target + '-ace'),
        wrapp = editor.parent();

    if (el) {
        $(el).parents('ul').eq(0).find('li').removeClass('active');
        $(el).parent('li').addClass('active');
    }
    
    if (textarea.data('ace') != true) {
        var acetor = ace.edit(target + '-ace');
        acetor.setTheme("ace/theme/chrome");
        acetor.getSession().setMode("ace/mode/smarty");
        acetor.setOptions({
            minLines: 15,
            maxLines: 99999,
            highlightActiveLine: false
        });

        textarea.data('ace', true)
        textarea.data('aceeditor', acetor);
        
        textarea.parents('form').on('submit', function(){
            textarea.val(acetor.getValue());
        })
    }
    if (textarea.data('ace') == true) {
        textarea.data('aceeditor').getSession().setValue(textarea.val());

        textarea.hide();
        wrapp.show();
    }
    return false;
};

HBInputTranslate.aceOff = function(el, target) {
    var textarea = $('#' + target),
        editor = $('#' + target + '-ace'),
        wrapp = editor.parent();

    if (el) {
        $(el).parents('ul').eq(0).find('li').removeClass('active');
        $(el).parent('li').addClass('active');
    }

    if (textarea.data('ace') == true) {
        textarea.val(textarea.data('aceeditor').getValue());
        textarea.show();
        wrapp.hide();
    }
    return false;

};

function send_msg(type) {
    if ((type == 'clients' && $("input[class=check]:checked").length < 1) || (type != 'allclients' && $("input[class=check]:checked").length == 0)) {
        alert('Nothing checked.');
        return false;
    }
    else {
        $('#testform').removeAttr('action');
        $('#testform').attr('action', '?cmd=sendmessage');
        $('#testform').append('<input type="hidden" name="type" value="' + type + '" />');
        $('#testform').submit();
        return false;
    }

}
;

(function($) {
    jQuery.event.special.destroyed = {
        remove: function(o) {
            if (o.handler) {
                o.handler()
            }
        }
    }
})(jQuery)

var Chosen = {
    inp: function(that) {

        if (typeof jQuery.fn.chosen != 'function') {
            $('<style type="text/css">@import url("templates/default/js/chosen/chosen.css")</style>').appendTo("head");
            $.getScript('templates/default/js/chosen/chosen.min.js', function() {
                Chosen.inp(that);
                return false;
            });
            return false;
        }

        var xhr = false,
            nextsearch = false,
            selected = [that.attr('default')],
            lang_loading = 'Searching for..',
            lang_noresult = 'No results match',
            _search = function(evt) {
                var search = $(this);
                if (!selected.length) {
                    that.find(':selected').each(function() {
                        selected.push($(this).val())
                    });
                }
                if (xhr) {
                    nextsearch = evt;
                    return false;
                }
                that.data('chosen').results_none_found = lang_loading;
                xhr = $.post('?cmd=clients&action=search&lightweight=1', {
                    query: evt && evt.query || search.val()
                }, function(data) {
                    var change = !nextsearch;
                    xhr = false;
                    var ev = evt && evt.type && evt || $.extend({}, nextsearch);
                    if (nextsearch) {
                        nextsearch = false;
                        _search.call(search[0], ev);
                    } else {
                        that.data('chosen').results_none_found = 'No results match';
                    }

                    that.find('.chosen').remove();
                    if (data.list != undefined) {
                        if (data.list.length == 1)
                            selected.push(data.list[0][0])

                        for (var i = 0; i < data.list.length; i++) {
                            var name = data.list[i][3].length ? data.list[i][3] + ' - ' + data.list[i][1] + ' ' + data.list[i][2] : data.list[i][1] + ' ' + data.list[i][2];
                            that.append('<option class="chosen" value="' + data.list[i][0] + '">#' + data.list[i][0] + ' ' + name + '</option>');
                        }
                        that.val(selected.pop());
                        that.trigger("liszt:updated")

                        if (ev && ev.type) {
                            var sf = that.data('chosen').search_field;
                            sf.val(sf.val().replace(/( )\s+/g, '$1'));

                            that.data('chosen').results_show();
                            if (change)
                                that.change();
                        }
                    }
                    selected = [];
                })

            }

        that.append('<option class="loader" value="">Loading..</option>').on('liszt:ready', function(evt, ob) {
            ob.chosen.search_container.on('keyup', 'input', _search);
            ob.chosen.search_contains = true;
            ob.chosen.show_search_field_default = function() {
            };
            that.data('chosen', ob.chosen);
            ob.chosen.results_none_found = lang_loading;
            _search.call(ob.chosen.search_container, {query: selected[0] || ''})
        });


        if (!that.hasClass('chzn-done')) {
            var incubator = false, parent = false;
            if (!that.is(':visible')) {
                parent = that.wrap('<span></span>').parent();
                incubator = $('<div style="position:abolute"></div>').appendTo('body');
                that.detach().appendTo(incubator).show();
            }
            that.addClass('chzn-css-loaded').find('.loader').remove();
            var fakeListener = setInterval(function() {
                if (that.css("cursor") === "pointer") {
                    clearInterval(fakeListener)
                    that.removeClass('chzn-css-loaded').chosen();
                    if (incubator) {
                        incubator.children().detach().appendTo(parent);
                        that.unwrap();
                        //parent.hide();
                        incubator.remove();
                    }
                }
            }, 50)
        }
    },
    recovery: function(that, i) {
        that.bind('destroyed', function() {
            setTimeout(function() {
                var that = $('select[load]').eq(i);
                Chosen.recovery(that, i)
                Chosen.inp(that);
            }, 60);
        })
    },
    find: function(that, i) {
        if (that != undefined) {
            Chosen.recovery(that, i);
            Chosen.inp(that);
        } else {
            $('select[load]').each(function(i) {
                var that = $(this);
                if (that.attr('load') == 'clients')
                    Chosen.recovery(that, i);
                Chosen.inp(that);
            })
        }
    }
};

var AdminNotes = {
    visible: false,
    show: function() {
        AdminNotes.hide();
        $('#AdmNotes').show().find('.admin-note-new').show();
        $('#AdmNotes .admin-note-new textarea').focus();
        AdminNotes.visible = true;
        return false;
    },
    hide: function() {
        $('#AdmNotes .admin-note-new').hide();
        $('#AdmNotes .admin-note-edit:visible').each(function() {
            $(this).hide().prev().show();
        });
        return false;
    },
    addNew: function() {
        var form = $('textarea, input', '#AdmNotes .admin-note-new'),
            data = form.serializeObject();
        if (data.note && data.note.length) {
            form.filter('textarea').val('');
            $('#AdmNotes .admin-note-attach').html('');

            AdminNotes.hide();
            data.make = 'addNote';
            $.post($('#notesurl').attr('href'), data, AdminNotes.ajax);

            var date = AdminNotes.dateformat.replace('d', ("0" + ts.getDate()).slice(-2))
                .replace('Y', ts.getFullYear())
                .replace('m', ("0" + (ts.getMonth() + 1)).slice(-2))
                + ' ' + ("0" + ts.getHours()).slice(-2) + ':' + ("0" + ts.getMinutes()).slice(-2) + ':' + ("0" + ts.getSeconds()).slice(-2);
            $('#notesContainer').prepend('<div class="admin-note"><div class="left">' + date + ' by ' + AdminNotes.me + '</div><div class="admin-note-body"><br />' + data.note + '</div></div>');
        }
        return false;
    },
    edit: function(id) {
        var value = $('#AdmNotes textarea:visible:last').val();
        if (value && value.length)
            $.post($('#notesurl').attr('href'), {make: 'editNote', note: value, noteid: id}, AdminNotes.ajax);
        return false;
    },
    init: function() {
        var noteslist = $('#AdmNotes');
        if (noteslist.length) {
            $.get($('#notesurl').attr('href') + '&make=getNotes', AdminNotes.ajax);
        }
    },
    del: function(id) {
        $('#notesContainer .admin-note[rel=' + id + ']').remove();
        $.post($('#notesurl').attr('href'), {make: 'delNote', noteid: id}, AdminNotes.ajax);
        return false;
    },
    addFile: function() {
        var resultlist = {},
            place = $('<div class="result"><input type="file" data-upload="?cmd=downloads&action=upload" /></div>').appendTo('.admin-note-new .admin-note-attach')
            .bind('fileuploadsend', function(e, data) {
                place.children().hide();
                for (var i in data.files) {
                    resultlist[i] = $('<div class="upload-result"><a class="attachment" >' + data.files[i].name + '</a> <span class="ui-autocomplete-loading" style="padding: 10px;"></span></div>').appendTo(place);
                }
            })
            .bind('fileuploadalways', function(e, data) {
                place.children('input').remove();
                for (var i in data.result) {
                    if (resultlist[i]) {
                        var r = resultlist[i];
                        r.children('span').remove();
                        if (data.result[i].error)
                            r.append('<span>' + data.result[i].error + '</span>');
                        else {
                            r.append('<input name="attachments[]" value="' + data.result[i].hash + '" type="hidden"/>');
                            $('<a href="#" class="editbtn"></a>').append('<small>&#91;Remove&#93;</small>').appendTo(r).click(function() {
                                $.post(data.result[i].delete_url);
                                r.remove();
                                return false;
                            });
                        }
                    }
                }
                //place.children().remove().text(data.result);
            });
        fileupload_init();
        return false;
    },
    ajax: function(data) {
        data = parse_response(data);
        if (data.length) {
            $('#AdmNotes').show()
            $('#notesContainer').html(data);
        } else if (!AdminNotes.visible) {
            //$('#AdmNotes').hide()
            $('#notesContainer').html('');
        }
    }
};
