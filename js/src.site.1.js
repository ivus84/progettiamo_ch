/*!
 * hoverIntent r7 // 2013.03.11 // jQuery 1.9.1+ Copyright 2007, 2013 Brian Cherne
 */
(function (e) { e.fn.hoverIntent = function (t, n, r) { var i = { interval: 100, sensitivity: 7, timeout: 0 }; if (typeof t === "object") { i = e.extend(i, t) } else if (e.isFunction(n)) { i = e.extend(i, { over: t, out: n, selector: r }) } else { i = e.extend(i, { over: t, out: t, selector: n }) } var s, o, u, a; var f = function (e) { s = e.pageX; o = e.pageY }; var l = function (t, n) { n.hoverIntent_t = clearTimeout(n.hoverIntent_t); if (Math.abs(u - s) + Math.abs(a - o) < i.sensitivity) { e(n).off("mousemove.hoverIntent", f); n.hoverIntent_s = 1; return i.over.apply(n, [t]) } else { u = s; a = o; n.hoverIntent_t = setTimeout(function () { l(t, n) }, i.interval) } }; var c = function (e, t) { t.hoverIntent_t = clearTimeout(t.hoverIntent_t); t.hoverIntent_s = 0; return i.out.apply(t, [e]) }; var h = function (t) { var n = jQuery.extend({}, t); var r = this; if (r.hoverIntent_t) { r.hoverIntent_t = clearTimeout(r.hoverIntent_t) } if (t.type == "mouseenter") { u = n.pageX; a = n.pageY; e(r).on("mousemove.hoverIntent", f); if (r.hoverIntent_s != 1) { r.hoverIntent_t = setTimeout(function () { l(n, r) }, i.interval) } } else { e(r).off("mousemove.hoverIntent", f); if (r.hoverIntent_s == 1) { r.hoverIntent_t = setTimeout(function () { c(n, r) }, i.timeout) } } }; return this.on({ "mouseenter.hoverIntent": h, "mouseleave.hoverIntent": h }, i.selector) } })(jQuery)

/*jQuery easing*/
jQuery.easing.jswing = jQuery.easing.swing, jQuery.extend(jQuery.easing, { def: "easeOutQuad", swing: function (a, b, c, d, e) { return jQuery.easing[jQuery.easing.def](a, b, c, d, e) }, easeInQuad: function (a, b, c, d, e) { return d * (b /= e) * b + c }, easeOutQuad: function (a, b, c, d, e) { return -d * (b /= e) * (b - 2) + c }, easeInOutQuad: function (a, b, c, d, e) { return 1 > (b /= e / 2) ? d / 2 * b * b + c : -d / 2 * (--b * (b - 2) - 1) + c }, easeInCubic: function (a, b, c, d, e) { return d * (b /= e) * b * b + c }, easeOutCubic: function (a, b, c, d, e) { return d * ((b = b / e - 1) * b * b + 1) + c }, easeInOutCubic: function (a, b, c, d, e) { return 1 > (b /= e / 2) ? d / 2 * b * b * b + c : d / 2 * ((b -= 2) * b * b + 2) + c }, easeInQuart: function (a, b, c, d, e) { return d * (b /= e) * b * b * b + c }, easeOutQuart: function (a, b, c, d, e) { return -d * ((b = b / e - 1) * b * b * b - 1) + c }, easeInOutQuart: function (a, b, c, d, e) { return 1 > (b /= e / 2) ? d / 2 * b * b * b * b + c : -d / 2 * ((b -= 2) * b * b * b - 2) + c }, easeInQuint: function (a, b, c, d, e) { return d * (b /= e) * b * b * b * b + c }, easeOutQuint: function (a, b, c, d, e) { return d * ((b = b / e - 1) * b * b * b * b + 1) + c }, easeInOutQuint: function (a, b, c, d, e) { return 1 > (b /= e / 2) ? d / 2 * b * b * b * b * b + c : d / 2 * ((b -= 2) * b * b * b * b + 2) + c }, easeInSine: function (a, b, c, d, e) { return -d * Math.cos(b / e * (Math.PI / 2)) + d + c }, easeOutSine: function (a, b, c, d, e) { return d * Math.sin(b / e * (Math.PI / 2)) + c }, easeInOutSine: function (a, b, c, d, e) { return -d / 2 * (Math.cos(Math.PI * b / e) - 1) + c }, easeInExpo: function (a, b, c, d, e) { return 0 == b ? c : d * Math.pow(2, 10 * (b / e - 1)) + c }, easeOutExpo: function (a, b, c, d, e) { return b == e ? c + d : d * (-Math.pow(2, -10 * b / e) + 1) + c }, easeInOutExpo: function (a, b, c, d, e) { return 0 == b ? c : b == e ? c + d : 1 > (b /= e / 2) ? d / 2 * Math.pow(2, 10 * (b - 1)) + c : d / 2 * (-Math.pow(2, -10 * --b) + 2) + c }, easeInCirc: function (a, b, c, d, e) { return -d * (Math.sqrt(1 - (b /= e) * b) - 1) + c }, easeOutCirc: function (a, b, c, d, e) { return d * Math.sqrt(1 - (b = b / e - 1) * b) + c }, easeInOutCirc: function (a, b, c, d, e) { return 1 > (b /= e / 2) ? -d / 2 * (Math.sqrt(1 - b * b) - 1) + c : d / 2 * (Math.sqrt(1 - (b -= 2) * b) + 1) + c }, easeInElastic: function (a, b, c, d, e) { var f = 1.70158, g = 0, h = d; if (0 == b) return c; if (1 == (b /= e)) return c + d; if (g || (g = .3 * e), Math.abs(d) > h) { h = d; var f = g / 4 } else var f = g / (2 * Math.PI) * Math.asin(d / h); return -(h * Math.pow(2, 10 * (b -= 1)) * Math.sin((b * e - f) * 2 * Math.PI / g)) + c }, easeOutElastic: function (a, b, c, d, e) { var f = 1.70158, g = 0, h = d; if (0 == b) return c; if (1 == (b /= e)) return c + d; if (g || (g = .3 * e), Math.abs(d) > h) { h = d; var f = g / 4 } else var f = g / (2 * Math.PI) * Math.asin(d / h); return h * Math.pow(2, -10 * b) * Math.sin((b * e - f) * 2 * Math.PI / g) + d + c }, easeInOutElastic: function (a, b, c, d, e) { var f = 1.70158, g = 0, h = d; if (0 == b) return c; if (2 == (b /= e / 2)) return c + d; if (g || (g = e * .3 * 1.5), Math.abs(d) > h) { h = d; var f = g / 4 } else var f = g / (2 * Math.PI) * Math.asin(d / h); return 1 > b ? -.5 * h * Math.pow(2, 10 * (b -= 1)) * Math.sin((b * e - f) * 2 * Math.PI / g) + c : .5 * h * Math.pow(2, -10 * (b -= 1)) * Math.sin((b * e - f) * 2 * Math.PI / g) + d + c }, easeInBack: function (a, b, c, d, e, f) { return void 0 == f && (f = 1.70158), d * (b /= e) * b * ((f + 1) * b - f) + c }, easeOutBack: function (a, b, c, d, e, f) { return void 0 == f && (f = 1.70158), d * ((b = b / e - 1) * b * ((f + 1) * b + f) + 1) + c }, easeInOutBack: function (a, b, c, d, e, f) { return void 0 == f && (f = 1.70158), 1 > (b /= e / 2) ? d / 2 * b * b * (((f *= 1.525) + 1) * b - f) + c : d / 2 * ((b -= 2) * b * (((f *= 1.525) + 1) * b + f) + 2) + c }, easeInBounce: function (a, b, c, d, e) { return d - jQuery.easing.easeOutBounce(a, e - b, 0, d, e) + c }, easeOutBounce: function (a, b, c, d, e) { return 1 / 2.75 > (b /= e) ? d * 7.5625 * b * b + c : 2 / 2.75 > b ? d * (7.5625 * (b -= 1.5 / 2.75) * b + .75) + c : 2.5 / 2.75 > b ? d * (7.5625 * (b -= 2.25 / 2.75) * b + .9375) + c : d * (7.5625 * (b -= 2.625 / 2.75) * b + .984375) + c }, easeInOutBounce: function (a, b, c, d, e) { return e / 2 > b ? .5 * jQuery.easing.easeInBounce(a, 2 * b, 0, d, e) + c : .5 * jQuery.easing.easeOutBounce(a, 2 * b - e, 0, d, e) + .5 * d + c } });

/*jQuery viewport*/
(function ($) { $.belowthefold = function (element, settings) { var fold = $(window).height() + $(window).scrollTop(); return fold <= $(element).offset().top - settings.threshold; }; $.abovethetop = function (element, settings) { var top = $(window).scrollTop(); return top >= $(element).offset().top + $(element).height() - settings.threshold; }; $.rightofscreen = function (element, settings) { var fold = $(window).width() + $(window).scrollLeft(); return fold <= $(element).offset().left - settings.threshold; }; $.leftofscreen = function (element, settings) { var left = $(window).scrollLeft(); return left >= $(element).offset().left + $(element).width() - settings.threshold; }; $.inviewport = function (element, settings) { return !$.rightofscreen(element, settings) && !$.leftofscreen(element, settings) && !$.belowthefold(element, settings) && !$.abovethetop(element, settings); }; $.extend($.expr[':'], { "below-the-fold": function (a, i, m) { return $.belowthefold(a, { threshold: 0 }); }, "above-the-top": function (a, i, m) { return $.abovethetop(a, { threshold: 0 }); }, "left-of-screen": function (a, i, m) { return $.leftofscreen(a, { threshold: 0 }); }, "right-of-screen": function (a, i, m) { return $.rightofscreen(a, { threshold: 0 }); }, "in-viewport": function (a, i, m) { return $.inviewport(a, { threshold: 0 }); } }); })(jQuery);

/*jQuery touchSwipe*/
(function (e) { var o = "left", n = "right", d = "up", v = "down", c = "in", w = "out", l = "none", r = "auto", k = "swipe", s = "pinch", x = "tap", i = "doubletap", b = "longtap", A = "horizontal", t = "vertical", h = "all", q = 10, f = "start", j = "move", g = "end", p = "cancel", a = "ontouchstart" in window, y = "TouchSwipe"; var m = { fingers: 1, threshold: 75, cancelThreshold: 25, pinchThreshold: 20, maxTimeThreshold: null, fingerReleaseThreshold: 250, longTapThreshold: 500, doubleTapThreshold: 200, swipe: null, swipeLeft: null, swipeRight: null, swipeUp: null, swipeDown: null, swipeStatus: null, pinchIn: null, pinchOut: null, pinchStatus: null, click: null, tap: null, doubleTap: null, longTap: null, triggerOnTouchEnd: true, triggerOnTouchLeave: false, allowPageScroll: "auto", fallbackToMouseEvents: true, excludedElements: "button, input, select, textarea, a, .noSwipe" }; e.fn.swipe = function (D) { var C = e(this), B = C.data(y); if (B && typeof D === "string") { if (B[D]) { return B[D].apply(this, Array.prototype.slice.call(arguments, 1)) } else { e.error("Method " + D + " does not exist on jQuery.swipe") } } else { if (!B && (typeof D === "object" || !D)) { return u.apply(this, arguments) } } return C }; e.fn.swipe.defaults = m; e.fn.swipe.phases = { PHASE_START: f, PHASE_MOVE: j, PHASE_END: g, PHASE_CANCEL: p }; e.fn.swipe.directions = { LEFT: o, RIGHT: n, UP: d, DOWN: v, IN: c, OUT: w }; e.fn.swipe.pageScroll = { NONE: l, HORIZONTAL: A, VERTICAL: t, AUTO: r }; e.fn.swipe.fingers = { ONE: 1, TWO: 2, THREE: 3, ALL: h }; function u(B) { if (B && (B.allowPageScroll === undefined && (B.swipe !== undefined || B.swipeStatus !== undefined))) { B.allowPageScroll = l } if (B.click !== undefined && B.tap === undefined) { B.tap = B.click } if (!B) { B = {} } B = e.extend({}, e.fn.swipe.defaults, B); return this.each(function () { var D = e(this); var C = D.data(y); if (!C) { C = new z(this, B); D.data(y, C) } }) } function z(a0, aq) { var av = (a || !aq.fallbackToMouseEvents), G = av ? "touchstart" : "mousedown", au = av ? "touchmove" : "mousemove", R = av ? "touchend" : "mouseup", P = av ? null : "mouseleave", az = "touchcancel"; var ac = 0, aL = null, Y = 0, aX = 0, aV = 0, D = 1, am = 0, aF = 0, J = null; var aN = e(a0); var W = "start"; var T = 0; var aM = null; var Q = 0, aY = 0, a1 = 0, aa = 0, K = 0; var aS = null; try { aN.bind(G, aJ); aN.bind(az, a5) } catch (ag) { e.error("events not supported " + G + "," + az + " on jQuery.swipe") } this.enable = function () { aN.bind(G, aJ); aN.bind(az, a5); return aN }; this.disable = function () { aG(); return aN }; this.destroy = function () { aG(); aN.data(y, null); return aN }; this.option = function (a7, a6) { if (aq[a7] !== undefined) { if (a6 === undefined) { return aq[a7] } else { aq[a7] = a6 } } else { e.error("Option " + a7 + " does not exist on jQuery.swipe.options") } }; function aJ(a8) { if (ax()) { return } if (e(a8.target).closest(aq.excludedElements, aN).length > 0) { return } var a9 = a8.originalEvent ? a8.originalEvent : a8; var a7, a6 = a ? a9.touches[0] : a9; W = f; if (a) { T = a9.touches.length } else { a8.preventDefault() } ac = 0; aL = null; aF = null; Y = 0; aX = 0; aV = 0; D = 1; am = 0; aM = af(); J = X(); O(); if (!a || (T === aq.fingers || aq.fingers === h) || aT()) { ae(0, a6); Q = ao(); if (T == 2) { ae(1, a9.touches[1]); aX = aV = ap(aM[0].start, aM[1].start) } if (aq.swipeStatus || aq.pinchStatus) { a7 = L(a9, W) } } else { a7 = false } if (a7 === false) { W = p; L(a9, W); return a7 } else { ak(true) } } function aZ(a9) { var bc = a9.originalEvent ? a9.originalEvent : a9; if (W === g || W === p || ai()) { return } var a8, a7 = a ? bc.touches[0] : bc; var ba = aD(a7); aY = ao(); if (a) { T = bc.touches.length } W = j; if (T == 2) { if (aX == 0) { ae(1, bc.touches[1]); aX = aV = ap(aM[0].start, aM[1].start) } else { aD(bc.touches[1]); aV = ap(aM[0].end, aM[1].end); aF = an(aM[0].end, aM[1].end) } D = a3(aX, aV); am = Math.abs(aX - aV) } if ((T === aq.fingers || aq.fingers === h) || !a || aT()) { aL = aH(ba.start, ba.end); ah(a9, aL); ac = aO(ba.start, ba.end); Y = aI(); aE(aL, ac); if (aq.swipeStatus || aq.pinchStatus) { a8 = L(bc, W) } if (!aq.triggerOnTouchEnd || aq.triggerOnTouchLeave) { var a6 = true; if (aq.triggerOnTouchLeave) { var bb = aU(this); a6 = B(ba.end, bb) } if (!aq.triggerOnTouchEnd && a6) { W = ay(j) } else { if (aq.triggerOnTouchLeave && !a6) { W = ay(g) } } if (W == p || W == g) { L(bc, W) } } } else { W = p; L(bc, W) } if (a8 === false) { W = p; L(bc, W) } } function I(a6) { var a7 = a6.originalEvent; if (a) { if (a7.touches.length > 0) { C(); return true } } if (ai()) { T = aa } a6.preventDefault(); aY = ao(); Y = aI(); if (aq.triggerOnTouchEnd || (aq.triggerOnTouchEnd == false && W === j)) { W = g; L(a7, W) } else { if (!aq.triggerOnTouchEnd && a2()) { W = g; aB(a7, W, x) } else { if (W === j) { W = p; L(a7, W) } } } ak(false) } function a5() { T = 0; aY = 0; Q = 0; aX = 0; aV = 0; D = 1; O(); ak(false) } function H(a6) { var a7 = a6.originalEvent; if (aq.triggerOnTouchLeave) { W = ay(g); L(a7, W) } } function aG() { aN.unbind(G, aJ); aN.unbind(az, a5); aN.unbind(au, aZ); aN.unbind(R, I); if (P) { aN.unbind(P, H) } ak(false) } function ay(a9) { var a8 = a9; var a7 = aw(); var a6 = aj(); if (!a7) { a8 = p } else { if (a6 && a9 == j && (!aq.triggerOnTouchEnd || aq.triggerOnTouchLeave)) { a8 = g } else { if (!a6 && a9 == g && aq.triggerOnTouchLeave) { a8 = p } } } return a8 } function L(a8, a6) { var a7 = undefined; if (F()) { a7 = aB(a8, a6, k) } else { if (M() && a7 !== false) { a7 = aB(a8, a6, s) } } if (aC() && a7 !== false) { a7 = aB(a8, a6, i) } else { if (al() && a7 !== false) { a7 = aB(a8, a6, b) } else { if (ad() && a7 !== false) { a7 = aB(a8, a6, x) } } } if (a6 === p) { a5(a8) } if (a6 === g) { if (a) { if (a8.touches.length == 0) { a5(a8) } } else { a5(a8) } } return a7 } function aB(a9, a6, a8) { var a7 = undefined; if (a8 == k) { aN.trigger("swipeStatus", [a6, aL || null, ac || 0, Y || 0, T]); if (aq.swipeStatus) { a7 = aq.swipeStatus.call(aN, a9, a6, aL || null, ac || 0, Y || 0, T); if (a7 === false) { return false } } if (a6 == g && aR()) { aN.trigger("swipe", [aL, ac, Y, T]); if (aq.swipe) { a7 = aq.swipe.call(aN, a9, aL, ac, Y, T); if (a7 === false) { return false } } switch (aL) { case o: aN.trigger("swipeLeft", [aL, ac, Y, T]); if (aq.swipeLeft) { a7 = aq.swipeLeft.call(aN, a9, aL, ac, Y, T) } break; case n: aN.trigger("swipeRight", [aL, ac, Y, T]); if (aq.swipeRight) { a7 = aq.swipeRight.call(aN, a9, aL, ac, Y, T) } break; case d: aN.trigger("swipeUp", [aL, ac, Y, T]); if (aq.swipeUp) { a7 = aq.swipeUp.call(aN, a9, aL, ac, Y, T) } break; case v: aN.trigger("swipeDown", [aL, ac, Y, T]); if (aq.swipeDown) { a7 = aq.swipeDown.call(aN, a9, aL, ac, Y, T) } break } } } if (a8 == s) { aN.trigger("pinchStatus", [a6, aF || null, am || 0, Y || 0, T, D]); if (aq.pinchStatus) { a7 = aq.pinchStatus.call(aN, a9, a6, aF || null, am || 0, Y || 0, T, D); if (a7 === false) { return false } } if (a6 == g && a4()) { switch (aF) { case c: aN.trigger("pinchIn", [aF || null, am || 0, Y || 0, T, D]); if (aq.pinchIn) { a7 = aq.pinchIn.call(aN, a9, aF || null, am || 0, Y || 0, T, D) } break; case w: aN.trigger("pinchOut", [aF || null, am || 0, Y || 0, T, D]); if (aq.pinchOut) { a7 = aq.pinchOut.call(aN, a9, aF || null, am || 0, Y || 0, T, D) } break } } } if (a8 == x) { if (a6 === p || a6 === g) { clearTimeout(aS); if (V() && !E()) { K = ao(); aS = setTimeout(e.proxy(function () { K = null; aN.trigger("tap", [a9.target]); if (aq.tap) { a7 = aq.tap.call(aN, a9, a9.target) } }, this), aq.doubleTapThreshold) } else { K = null; aN.trigger("tap", [a9.target]); if (aq.tap) { a7 = aq.tap.call(aN, a9, a9.target) } } } } else { if (a8 == i) { if (a6 === p || a6 === g) { clearTimeout(aS); K = null; aN.trigger("doubletap", [a9.target]); if (aq.doubleTap) { a7 = aq.doubleTap.call(aN, a9, a9.target) } } } else { if (a8 == b) { if (a6 === p || a6 === g) { clearTimeout(aS); K = null; aN.trigger("longtap", [a9.target]); if (aq.longTap) { a7 = aq.longTap.call(aN, a9, a9.target) } } } } } return a7 } function aj() { var a6 = true; if (aq.threshold !== null) { a6 = ac >= aq.threshold } if (a6 && aq.cancelThreshold !== null) { a6 = (aP(aL) - ac) < aq.cancelThreshold } return a6 } function ab() { if (aq.pinchThreshold !== null) { return am >= aq.pinchThreshold } return true } function aw() { var a6; if (aq.maxTimeThreshold) { if (Y >= aq.maxTimeThreshold) { a6 = false } else { a6 = true } } else { a6 = true } return a6 } function ah(a6, a7) { if (aq.allowPageScroll === l || aT()) { a6.preventDefault() } else { var a8 = aq.allowPageScroll === r; switch (a7) { case o: if ((aq.swipeLeft && a8) || (!a8 && aq.allowPageScroll != A)) { a6.preventDefault() } break; case n: if ((aq.swipeRight && a8) || (!a8 && aq.allowPageScroll != A)) { a6.preventDefault() } break; case d: if ((aq.swipeUp && a8) || (!a8 && aq.allowPageScroll != t)) { a6.preventDefault() } break; case v: if ((aq.swipeDown && a8) || (!a8 && aq.allowPageScroll != t)) { a6.preventDefault() } break } } } function a4() { var a7 = aK(); var a6 = U(); var a8 = ab(); return a7 && a6 && a8 } function aT() { return !!(aq.pinchStatus || aq.pinchIn || aq.pinchOut) } function M() { return !!(a4() && aT()) } function aR() { var a8 = aw(); var ba = aj(); var a7 = aK(); var a6 = U(); var a9 = a6 && a7 && ba && a8; return a9 } function S() { return !!(aq.swipe || aq.swipeStatus || aq.swipeLeft || aq.swipeRight || aq.swipeUp || aq.swipeDown) } function F() { return !!(aR() && S()) } function aK() { return ((T === aq.fingers || aq.fingers === h) || !a) } function U() { return aM[0].end.x !== 0 } function a2() { return !!(aq.tap) } function V() { return !!(aq.doubleTap) } function aQ() { return !!(aq.longTap) } function N() { if (K == null) { return false } var a6 = ao(); return (V() && ((a6 - K) <= aq.doubleTapThreshold)) } function E() { return N() } function at() { return ((T === 1 || !a) && (isNaN(ac) || ac === 0)) } function aW() { return ((Y > aq.longTapThreshold) && (ac < q)) } function ad() { return !!(at() && a2()) } function aC() { return !!(N() && V()) } function al() { return !!(aW() && aQ()) } function C() { a1 = ao(); aa = event.touches.length + 1 } function O() { a1 = 0; aa = 0 } function ai() { var a6 = false; if (a1) { var a7 = ao() - a1; if (a7 <= aq.fingerReleaseThreshold) { a6 = true } } return a6 } function ax() { return !!(aN.data(y + "_intouch") === true) } function ak(a6) { if (a6 === true) { aN.bind(au, aZ); aN.bind(R, I); if (P) { aN.bind(P, H) } } else { aN.unbind(au, aZ, false); aN.unbind(R, I, false); if (P) { aN.unbind(P, H, false) } } aN.data(y + "_intouch", a6 === true) } function ae(a7, a6) { var a8 = a6.identifier !== undefined ? a6.identifier : 0; aM[a7].identifier = a8; aM[a7].start.x = aM[a7].end.x = a6.pageX || a6.clientX; aM[a7].start.y = aM[a7].end.y = a6.pageY || a6.clientY; return aM[a7] } function aD(a6) { var a8 = a6.identifier !== undefined ? a6.identifier : 0; var a7 = Z(a8); a7.end.x = a6.pageX || a6.clientX; a7.end.y = a6.pageY || a6.clientY; return a7 } function Z(a7) { for (var a6 = 0; a6 < aM.length; a6++) { if (aM[a6].identifier == a7) { return aM[a6] } } } function af() { var a6 = []; for (var a7 = 0; a7 <= 5; a7++) { a6.push({ start: { x: 0, y: 0 }, end: { x: 0, y: 0 }, identifier: 0 }) } return a6 } function aE(a6, a7) { a7 = Math.max(a7, aP(a6)); J[a6].distance = a7 } function aP(a6) { return J[a6].distance } function X() { var a6 = {}; a6[o] = ar(o); a6[n] = ar(n); a6[d] = ar(d); a6[v] = ar(v); return a6 } function ar(a6) { return { direction: a6, distance: 0 } } function aI() { return aY - Q } function ap(a9, a8) { var a7 = Math.abs(a9.x - a8.x); var a6 = Math.abs(a9.y - a8.y); return Math.round(Math.sqrt(a7 * a7 + a6 * a6)) } function a3(a6, a7) { var a8 = (a7 / a6) * 1; return a8.toFixed(2) } function an() { if (D < 1) { return w } else { return c } } function aO(a7, a6) { return Math.round(Math.sqrt(Math.pow(a6.x - a7.x, 2) + Math.pow(a6.y - a7.y, 2))) } function aA(a9, a7) { var a6 = a9.x - a7.x; var bb = a7.y - a9.y; var a8 = Math.atan2(bb, a6); var ba = Math.round(a8 * 180 / Math.PI); if (ba < 0) { ba = 360 - Math.abs(ba) } return ba } function aH(a7, a6) { var a8 = aA(a7, a6); if ((a8 <= 45) && (a8 >= 0)) { return o } else { if ((a8 <= 360) && (a8 >= 315)) { return o } else { if ((a8 >= 135) && (a8 <= 225)) { return n } else { if ((a8 > 45) && (a8 < 135)) { return v } else { return d } } } } } function ao() { var a6 = new Date(); return a6.getTime() } function aU(a6) { a6 = e(a6); var a8 = a6.offset(); var a7 = { left: a8.left, right: a8.left + a6.outerWidth(), top: a8.top, bottom: a8.top + a6.outerHeight() }; return a7 } function B(a6, a7) { return (a6.x > a7.left && a6.x < a7.right && a6.y > a7.top && a6.y < a7.bottom) } } })(jQuery);


/*main site functions
 * Copyright 2014 progettiamo.ch
 */

jQuery.easing.def = "easeOutQuint";
var queuedScript = ""
var oldIeBrowser = isiphone = isipad = ismobile = isandroid = ismsie = isphone = wphone = ischrome = isfirefox = false;
var isdesktop = true;
var clientNavigator = navigator.userAgent.toLowerCase();
var actslide;
var slideTimer;
var changeHomeList;
var prevhomeContent;
var hideSubs;
var projectsScript = '/js/src.projects.js'
//IB: 160915 per ambiente di test
//var loginSet = 'https://www.progettiamo.ch/login/'.
var loginSet = 'http://barone.mvservice.com:33181/login/'
loginSet = 'http://' + window.location.host + '/login/'

//IB: 160915 per ambiente di test
var gtFId;
var self = this;
self.lastScroll = self.thisScroll = new Date().getTime();
var PrevScroll = -1;
var schedeloaded = firstload = firstclicked = actSMen = men_open = totSlides = 0;
var viewprojectlist = ""
var jqXHR = null;
var slidehomelist = 0;



iniSite = function (modep, modei) {
    checkNavigator()
    setHype()

    if ($('#language_menu').size() == 0) $('div.searchMenu').css({ left: '0%', width: '100%' })

    if ($('body').hasClass('progetti')) $.getScript(projectsScript, function () {

        setTimeout(function () {
            setTimeout(function () { $('body.progetti div.homeProjects').css('display', 'none') }, 20)
            init_projectPage()


            $('body.progetti a.gImg').fancyLavb();
            if (modei.length > 0) eval(modei)
            if (queuedScript.length > 0) eval(queuedScript)
        }, 100)
    })

    if (ismsie) $('#mainLogo img').css('background-image', 'url(/images/progettiamo_logo_mid.png)')
    if ($('body').hasClass('editproject')) $('div.searchMenu').html('')

    setScroll()
    projectsPictures()



    $('body.progetti div.pLeft img.dedup').tooltipster();
    $('body.progetti div.pLeft img.bonus').tooltipster({ contentAsHTML: true });
    if (oldIeBrowser) {
        $('div.profileContent').addClass('profileIE')
        $('#ff').css('display', 'inline')
        $('#ff').css('filter', 'alpha(opacity=0)')
        $('#ff').css('position', 'absolute')
        $('.projectsInfo img').each(function () {
            var bgGet = $(this).css('background-image');
            bgGet = bgGet.replace('url(', '').replace(')', '').replace(/\"/g, ''); ;
            bgGet = bgGet.replace('.png', '_small.png')
            $(this).css('background-image', 'url(' + bgGet + ')');
            $(this).width(43)
        })
    }

    $('#language_menu').click(function () {
        $('.navLang').slideDown();
        $('.navLang').mouseleave(function () { $(this).slideUp() });
        hideMenL = setTimeout(function () { $('.navLang').slideUp() }, 1500);
    })

    $('#project_search').submit(function (event) {
        event.preventDefault();
        searchprojects('tag', $('input.sstring').val(), $(this));
        return false;
    })

    if ($('body').hasClass('progetti')) $('div.testimonial').remove()

    getProjects();
    gtFId = $('div.projectsTitle').eq(0)

    timeloadSlideshow = 500
    if ($('div.homeBanner').size() > 0) { timeloadSlideshow = 12000 }

    if (!$('body').hasClass('home')) {
        $('div.homeProjects').css('display', 'none');
        loadProjectsGroups()
    } else {
        fbLoadHome()
        if ($("div.homeSlideshow").size() > 0) {
            setTimeout(function () { slideshowInit = 0; $('.homeSlideshow li').eq(0).find('a').trigger('click') }, timeloadSlideshow)
            if ($('div.headerLogged').size() > 0) $("div.headerLogged").css('margin-bottom', '10px')

            if ($('div.homeBanner').size() > 0) { changeHList(gtFId); slidehomelist = 1; }

        }


        loadProjectsGroups()

        $('div.homeNews').each(function () {
            var offset = 0;
            objNewsContainer = $(this)
            objindex = objNewsContainer.index('div.homeNews')
            
            numnews = objNewsContainer.find('div.newsScroller > div').size()
            width = objNewsContainer.width();
            if (objNewsContainer.find('div.newsScroller').prev().attr('id') == 'fbPage') {
                width = width/2 ;
            }
            perlinenews = parseInt(width / objNewsContainer.find('div.newsScroller > div').eq(0).width())
            $(this).attr("data-pages", perlinenews)
            if (numnews > perlinenews) {
                numpages = (Math.ceil(numnews / perlinenews))
                $('<img class="arrow" src="/images/arrow_next_home.png" onclick="moveNews(1,' + perlinenews + ',0,' + objindex + ')"/>').appendTo(objNewsContainer)
                $('<img class="arrow backarrow" src="/images/arrow_back_home.png" onclick="moveNews(-1,' + perlinenews + ',0,' + objindex + ')"/>').appendTo(objNewsContainer)
                
                $('<div class="dots"><div></div></div>').appendTo(objNewsContainer)

                for (x = 0; x < numpages; x++) {
                    $('<span onclick="moveNews(' + x + ',' + perlinenews + ',1,' + objindex + ')"></span>').appendTo(objNewsContainer.find('div.dots div'))
                }

                objNewsContainer.find('div.dots div span').eq(0).addClass('active');

            }
        });


    }

    $('div.searchMenu ul').hoverIntent(function () { void (0) }, function () { closeCats() });
    $('ul.mainMenu li:last').addClass('lastmenu')
    $('#socialMenu img.socialIco').hover(function () { gtAlt = $(this).attr('src'); gtAlt = gtAlt.replace('.', '_o.'); $(this).attr('src', gtAlt); }, function () { gtAlt = $(this).attr('src'); gtAlt = gtAlt.replace('_o.', '.'); $(this).attr('src', gtAlt); })

    $('ul.bmenu li a, a.vote').fancybox({
        minWidth: 300,
        minHeight: 400,
        maxWidth: 600,
        maxHeight: 500,
        autosize: true,
        padding: 0,
        type: 'iframe',
        iframe: {
            scrolling: 'auto',
            preload: true
        },
        beforeShow: function () { this.title = "" },
        helpers: {

            overlay: {
                css: {
                    'background': 'rgba(41, 47, 58, 0.2)'
                }
            }
        }
    });



    $('.colorBox').hyphenate(langHype);
    $('.colorBox').hover(function () {
        $('.colorBox').not($(this)).animate({ height: 224, marginTop: 0, marginBottom: 0 }, 300)
        $(this).animate({ height: 239, marginTop: -12, marginBottom: -13 }, 300)
    }, function () {
        void (0)
    })


    $('div.myprojectsList div.pic').each(function () {
        objGI = $(this)
        gtSrc = objGI.attr("data-href")
        if (gtSrc.indexOf("thumb_picture1") != -1) {
            objGI.delay(400).animate({ opacity: 1.0 }, 500)
            objGI.addClass('ldd')
        } else {
            $('<img/>').load(function () {
                loadedSrc = this.src;
                loadedSrc = loadedSrc.substring(loadedSrc.lastIndexOf("/"))
                loadedBase = loadedSrc.substring(0, loadedSrc.lastIndexOf("$"))
                loadedW = this.width; loadedH = this.height;
                loadedThumb = $('div.pic[data-href="' + loadedSrc + '"]')
                if (oldIeBrowser) { loadedSrc = loadedBase + "$230"; }
                loadedThumb.css('background-image', 'url(' + loadedSrc + ')')
                prop_img = parseFloat(loadedW / loadedH)
                if (((prop_img < 1.02 && prop_img > 0.79) || prop_img > 1.347) && prop_img != 1) loadedThumb.addClass('picV')
                if (prop_img < 0.8) loadedThumb.addClass('picH')
                loadedThumb.delay(300).animate({ opacity: 1.0 }, 500)
            })
				.attr('src', gtSrc)
        }
    })

    setSubs()

    setTimeout(function () {
        adaptSize(0)
        if ($('div.testimonial').size() > 0) getFacebookPosts()
    }, 400)

}


loadProjectsGroups = function () {
    $('div.homeNews > div > div img.bnews').not('.bnewsV').each(function () {
        sbg = $(this).css('background-image')
        sbg = sbg.substring(sbg.indexOf('(') + 1)
        //sbg = sbg.substring(0, sbg.indexOf(')'))
        sbg = sbg.substring(0, sbg.indexOf(')') - 1)
        sbg = sbg.substring(sbg.lastIndexOf('/'))
        ind = $(this).index('img.bnews')
        $('<img/>').load(function () {
            ri = this.width / this.height
            vind = $(this).data("x");
            if (ri < 1.1) $('img.bnews').eq(vind).addClass('bnewsV')
        }).attr('src', sbg).attr('data-x', ind)
    })
}


moveprojects = function (indd) {
    clearTimeout(slideTimer)
    gtLeft = $('div.container div.main').eq(indd).position().left;
    $('p.dots img.dot').removeClass('dAct')
    $('p.dots img.dot').eq(indd).addClass('dAct')
    $('div.donate').css('display', 'none');

    $('div.container').stop().animate({ left: gtLeft * -1 }, 800, function () {
        actslide = indd;
        setTimeout(function () { $('.homeSlideshow div.donate').css('display', 'inline'); }, 500)

        if (totSlides > 2) {
            slideTimer = setTimeout(function () { nextSlide(1) }, 11000) 
        }

    });
}

nextSlide = function (add) {
    clearTimeout(slideTimer)
    newSlide = actslide + add;
    if (newSlide >= (totSlides - 1)) newSlide = 0;
    if (newSlide < 0) return;
    moveprojects(newSlide)
}

var slideshowInit = 0;

getProjectsHome = function (modep, linkobk) {
    clearTimeout(slideTimer)
    $('div.container').stop(true, true)
    $('.homeSlideshow ul li').removeClass('active')
    linkobk.parent().addClass('active')

    //$('div.homeSlideshow div.slide').height(305)
    //$('div.homeSlideshow').height(325)
    $('div.homeSlideshow div.slide').height(585)
    $('div.homeSlideshow').height(600)
    $('.homeSlideshow div.container').html('<div class="pLoading"></div>');
    $('.homeSlideshow div.container').css('left', '0px')
    $('.homeSlideshow img.arrow').remove()
    $.ajax({
        url: "/project/getProjects_header.asp?load=" + modep + "&ssid=" + Math.floor((Math.random() * 111111) + 1),
        success: function (data) {
            
            if (data.length > 70) {
                $('div.homeBanner').slideUp(800, function () { $('div.homeBanner').remove(); });
                setTimeout(function () {
                    $('p.dots').remove()

                    $('.homeSlideshow div.container').html(data);
                    $('#fbPage').css('display', 'inline');

                    if (!oldIeBrowser) $('div.overtext p.overAbstract').hyphenate(langHype);

                    /*$(".homeSlideshow div.container").html($("div.main").sort(function () {
                        return Math.random() - 0.5;
                    }));*/

                    if (ismobile) {
                        $(".homeSlideshow div.container").swipe({
                            swipeLeft: function (event, direction, distance, duration, fingerCount) {
                                nextSlide(1)
                            },
                            swipeRight: function (event, direction, distance, duration, fingerCount) {
                                nextSlide(-1)
                            },
                            threshold: 50
                        })
                        $(".homeSlideshow div.main").swipe({
                            tap: function (event, target) {
                                eval($(this).find('div.donate').attr('onclick'))
                            }
                        })
                    }

                    if (!oldIeBrowser) {
                        firstObj = $('.homeSlideshow div.container div.main').eq(0)

                        if (slideshowInit == 0) {
                            var bgGet = firstObj.css('background-image');
                            bgGet = bgGet.replace('url(', '').replace(')', '').replace(/\"/g, '');

                            $('<img/>').load(function () {
                                $('div.homeSlideshow div.slide').fadeIn(600)

                                if (slideshowInit == 0 && slidehomelist == 0) { changeHList(gtFId); slideshowInit = 1; }

                            }).attr('src', bgGet);
                        }

                        $('.homeSlideshow div.container div.main').each(function () {
                            var bg = $(this).css('background-image');
                            bg = bg.replace('url(', '').replace(')', '').replace(/\"/g, '');;
                            $('<img/>').load(function () {
                                hW = this.width;
                                hH = this.height; gtSrc = this.src;
                                gtSrc = gtSrc.substring(gtSrc.lastIndexOf("/"))
                                prop_imgh = parseFloat(hW / hH)
                                if (prop_imgh < 1.55) {
                                    pDiff = 2.32 - prop_imgh;
                                    cutTop = parseInt(371 / pDiff / 3) * -1
                                    if (cutTop < 0) $('.homeSlideshow div.container div.main[alt="' + gtSrc + '"]').css('background-position', 'left ' + cutTop + 'px')
                                }
                                if (prop_imgh > 2.6) $('.homeSlideshow div.container div.main[alt="' + gtSrc + '"]').css('background-position', 'left center')
                                if (prop_imgh > 3.147) $('.homeSlideshow div.container div.main[alt="' + gtSrc + '"]').addClass('mainH')
                            }).attr('src', bg);
                        })
                    } else {
                        $('div.homeSlideshow div.slide').fadeIn(600)
                        $('div.homeSlideshow ul').fadeIn(600)

                        $('.homeSlideshow div.container div.main').each(function () {
                            var bg = $(this).css('background-image');
                            bg = bg.replace('url(', '').replace(')', '').replace(/\"/g, '');;
                            loadedBase = bg.substring(0, bg.lastIndexOf("$"))
                            $(this).css('background-image', 'url(' + loadedBase + '$960)')
                        })

                        if (slideshowInit == 0) { changeHList(gtFId); slideshowInit = 1; }

                    }

                    $('.homeSlideshow div.container').find('div.main').animate({ opacity: 1 }, 300)

                    totSlides = data.split('<div rel=').length;
                    $('div.homeSlideshow').css('margin-top', '0px')
                    //IB 170319 - Modifica layout home
                    //$('<p class="dots"></p>').prependTo('.homeSlideshow')
                    $('<p class="dots"></p>').appendTo('.homeSlideshow')

                    if (totSlides > 2) {

                        for (x = 1; x < totSlides; x++) { $('<img src="/images/vuoto.gif" class="dot" onclick="moveprojects(' + (x - 1) + ')"/>').appendTo('p.dots') }
                        $('p.dots img.dot').eq(0).addClass('dAct')
                        actslide = 0;

                        $('<div class="arrowbox"><img src="/images/arrow_back.png" class="arrow" onclick="nextSlide(-1)"/><img src="/images/arrow_next.png" class="arrow arrownext" onclick="nextSlide(1)"/></div>').appendTo('div.homeSlideshow')
                        setTimeout(function () { $('.homeSlideshow div.donate').css('display', 'inline'); }, 500)

                        slideTimer = setTimeout(function () { nextSlide(1) }, 13000)
                    } else {
                        $('<img src="/images/vuoto.gif" class="dot" style="opacity:0"/>').appendTo('p.dots')
                        setTimeout(function () { $('.homeSlideshow div.donate').css('display', 'inline'); }, 500)

                    }
                }, 300)
            } else {
                $('div.homeSlideshow div.container').html('')
                $('div.homeSlideshow div.slide').height(0)
                $('div.homeSlideshow').stop().animate({ height: '70px' }, 400)

            }
        }
    });
}



closeprojects = function (restore) {

    $('div.projectsList').html('');
    if ($('div.headerLogged').size() == 0) {
        $('.homeSlideshow').css('display', 'inline')
        //$('#centered').css('height', '1px')
    }

    $('div.projectsList').css('display', 'none')
    $('div.projectsTitle').each(function () { $(this).find('span').removeClass('active'); $(this).css('background-color', $(this).attr('rel')); $(this).css('color', '#fff'); $(this).css('background-image', 'url(/images/arrow_title.png)') })


    if ($('body').hasClass('progetti')) {
        $('div.homeNews').remove()
        $('div.pContainer').remove()
        $('div.projectsContainer').height(705)
        $('div.homeProjects').css('margin-bottom', '30px')
    }
}

viewCat = function (obj) {
    $('div.searchMenu span').removeClass('current');
    obj.find('ul').fadeIn()
    obj.addClass('current');

}

setString = function () {
    gtval = $('input.sstring').val()
    gtval1 = $('input.sstring').attr('name')
    if (gtval == gtval1) $('input.sstring').val('')
    $('input.sstring').blur(function () {
        if ($(this).val().length == 0) $(this).val($(this).attr('name'))
    })
}

var selectedArea = 0;
searchprojects = function (mode, cref, pobj) {
    //VB:sulla selezione salvo il nome dell'area selezionata

    cname = pobj.html();
    if (mode != 'tag') {
        selectedArea = cref;
        pobj.parent().parent().find('dt').html(cname)
    }
    closeCats()
    closeprojects(0)

    //$('#centered').css('height', '400px')

    //$('.homeSlideshow').css('display', 'none')
    loadProjects(cref, mode)
}

closeCats = function () {
    $('div.searchMenu span').removeClass('current');
    $('div.searchMenu span ul').stop(true, true).slideUp(50)
}


moveHeader = function (mod) {
    mobj = $('div.profileContainer > div');
    dLeft = mobj.position().left;
    dMove = mobj.parent().width()
    nLeft = dLeft - (dMove * mod)
    if (nLeft > 0) return;
    if (nLeft < (mobj.innerWidth() * -1)) return;
    mobj.animate({ left: nLeft + "px" }, 800)

}

getProjectsLogged = function (mode) {
    $('div.profileSelector').removeClass('active');
    $('div.profileSelector').eq(mode).addClass('active');
    $('div.headerLogged div.arrow').remove()
    $('div.profileContainer > div').css('left', '0px')
    clearTimeout(slideTimer)
    $('.homeSlideshow').css('display', 'none')
    $.ajax({
        url: "/project/getProjects_header.asp?mode=" + mode + "&ssid=" + Math.floor((Math.random() * 111111) + 1),
        success: function (msg) {
            if (msg.length > 0) {
                $('div.profileContainer').css('display', 'inline')
                $('div.headerLogged').animate({ height: '358px' }, 400)
                $('div.profileContainer').parent().animate({ height: '199px' }, 400)
                $('div.profileContainer div').html(msg)

                gCW = $('div.profileContainer div').innerWidth(); CW = $('div.profileContainer div').parent().width()
                if (gCW > CW) $('<div class="arrow bA" onclick="moveHeader(-1)"></div><div class="arrow nA" onclick="moveHeader(1)"></div>').appendTo($('div.headerLogged'))
                
                $('div.headerLogged div.arrow').delay(300).fadeIn()

                $('div.profileContainer div.main').hover(function () {
                    $(this).find('div.over').css('display', 'inline');
                    $(this).find('div.overtext').css('display', 'inline');
                }, function () {
                    $(this).find('div.over').css('display', 'none');
                    $(this).find('div.overtext').css('display', 'none');
                })

                if (oldIeBrowser) {
                    $('div.profileContainer > div div.main').each(function () {
                        var bgGet = $(this).css('background-image');
                        bgGet = bgGet.replace('url(', '').replace(')', '').replace(/\"/g, '');;
                        bgGet = bgGet.substring(0, bgGet.lastIndexOf("$")) + "$240";
                        $(this).css('background-image', 'url(' + bgGet + ')');
                    })
                }

                $('div.profileContainer div.main').click(function () { $(this).find('div.donate').trigger('click') });
            }
        },
        error: function (xhr, ajaxOptions, thrownError) {
            alert(thrownError);
        }
    });
}


getLogin = function () {
    addForm = $('<form method="post" action="' + loginSet + '"><input type="hidden" name="referrer_page" value="' + $('meta[property="og:url"]').attr('content') + '"/></form>').appendTo($('body'))
    addForm.submit()
}
getLoginPath=function(path){
    addForm = $('<form method="post" action="' + loginSet + '"><input type="hidden" name="referrer_page" value="' + path + '"/></form>').appendTo($('body'))
    addForm.submit()
}

schedePictures = function () {

    $('div.p_list:in-viewport div.pic').not('.ldd').each(function () {
        objGI = $(this)
        gtSrc = objGI.attr("data-href")
        //console.log(gtSrc)
        if (gtSrc.indexOf("thumb_picture1") != -1) {
            objGI.delay(400).animate({ opacity: 1.0 }, 500)
            objGI.addClass('ldd')
        } else {
            $('<img/>').load(function () {
                loadedSrc = this.src;
                loadedSrc = loadedSrc.substring(loadedSrc.lastIndexOf("/"))
                loadedBase = loadedSrc.substring(0, loadedSrc.lastIndexOf("$"))
                loadedW = this.width; loadedH = this.height;
                loadedThumb = $('div.pic[data-href="' + loadedSrc + '"]')

                loadedThumb.addClass('ldd')
                if (oldIeBrowser) { loadedSrc = loadedBase + "$230"; }
                //console.log(loadedSrc);
                loadedThumb.css('background-image', 'url(' + loadedSrc + ')')
                prop_img = parseFloat(loadedW / loadedH)
                if (((prop_img < 1.02 && prop_img > 0.79) || prop_img > 1.347) && prop_img != 1) loadedThumb.addClass('picV')
                if (prop_img < 0.8) loadedThumb.addClass('picH')

                loadedThumb.delay(300).animate({ opacity: 1.0 }, 500)
            })
                .attr('src', gtSrc)
        }
    });

}

projectsPictures = function () {

    if ($('.pLeft img').size() > 0) {
        var bg = $('.pLeft img').css('background-image');
        bg = bg.replace('url(', '').replace(')', '').replace(/\"/g, '');
        
        if (oldIeBrowser) {
            loadedBase = bg.substring(0, bg.lastIndexOf("$"))
            $('.pLeft img').css('background-image', 'url(' + loadedBase + '$160)')
            $('.pLeft img').css('background-position', 'left top')
            $('.pLeft img').css('background-color', '#FFFFFF')
        }
        $('<img/>').load(function () {
            loadedW = this.width; loadedH = this.height;
            if (loadedW / loadedH < 1.2) {
                $('.pLeft img').css('background-size', '100% auto')
                $('.pLeft img').css('background-color', '#fff')
            }

        })
.attr('src', bg)
    }
    //VB: Gestione dei div sulla nuova sezione amici
    $(document).ready(function () {
        $(".friends").mouseover(function () {
            img_friends = $(this);
            strId = img_friends.attr('id')
            id_img_friends = strId.substr(strId.lastIndexOf("_") + 1);
            div_friends = $('#div_friends_' + id_img_friends);
            div_friends.css('display', 'block');
        });

        //VB:lightbox
        $(".friends").click(function () {
            //Prima versione con jqueryDialog
            //            $('#img_ligthbox_' + id_img_friends).css("display", "block");
            //            $('#div_ligthbox_' + id_img_friends).dialog({
            //                closeOnEscape: true,
            //                modal: true,
            //                width: 430,
            //                height: 460,
            //                dialogClass: 'success-dialog',
            //                buttons: {}
            //            }).prev(".ui-dialog-titlebar").css("color", "white");
            //Seconda versione con fancybox
            gtUrl = $(this).attr('img_url');
            //console.log(gtUrl);
            parent.$.fancybox({
                beforeShow: function(){
                    $(".fancybox-skin").css("backgroundColor","transparent").css("box-shadow", "none");
                },
                href: gtUrl.substring(0,gtUrl.length),
                autoDimensions: false,
                autoSize: false,
                width: 420,
                height: 420,
                type: 'iframe',
                padding: 0,
                helpers: { overlay: { css: { 'background': 'rgba(255, 255, 255, 0.8)'}}}
            });
        });

        if (ismobile) {
            $(".friends").swipe({
                tap: function (event, target) {
                    $(".nContentF.friends").each(function () {
                        $(this).css('display', 'none');
                    });
                    img_friends = $(this);
                    strId = img_friends.attr('id')
                    id_img_friends = strId.substr(strId.lastIndexOf("_") + 1);
                    div_friends = $('#div_friends_' + id_img_friends);
                    div_friends.css('display', 'block');
                }
            });
        }

        $(".nContentF.friends").mouseout(function () {
            $(this).css('display', 'none');
        });
    });

    //VB:gestione del messaggio per "Nessun progetto trovato nella regione...

    showNoProjectModal = function (msg, type, searchString) {
        foundLi = $('li:contains("' + searchString + '")');

        $("#msg").html(msg);
        $("#dialog").dialog({
            closeOnEscape: false,
            open: function (event, ui) {
                $(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
            },
            modal: true,
            width: 410,
            height: 220,
            dialogClass: 'success-dialog',
            buttons: {
                Ok: function () {
                    $(this).dialog("close");
                    selectedArea = 0;
                    searchprojects('area', 0, foundLi);
                }
            }
        });
    }

    $('div.sponsors img').each(function () {
        var bg = $(this).css('background-image');
        bg = bg.replace('url(', '').replace(')', '').replace(/\"/g, '');
        loadedBase = bg.substring(0, bg.lastIndexOf("$"))
        nn = $(this).index('div.sponsors img')
        bgn = bg.substring(0, bg.indexOf('$')).substring(bg.lastIndexOf('=') + 1)
        
        if (oldIeBrowser) $(this).css('background-image', 'url(' + loadedBase + '$230)')

        $('<img/>').load(function () {
            srcn = this.src;
            ri = this.width / this.height
            srcn = srcn.substring(srcn.lastIndexOf('/'))
            srcn = srcn.substring(0, srcn.indexOf('$') + 1)
            
            vind = $(this).data("x");

            if (ri < 1.8) {
                $('div.sponsors img').eq(vind).addClass('vi')
                if (oldIeBrowser) $('div.sponsors img').eq(vind).css('background-image', 'url(' + srcn + '$140)')
            } else {
                if (ri >= 1.8 && ri < 4) $('div.sponsors img').eq(vind).addClass('hi')
            }

        }).attr('src', bg).attr('data-x', nn)
    });

}

//loadVimeoThumb = function (videoId, ttime) {
loadVimeoThumb = function (videoObj, ttime) {

    setTimeout(function () {
        var videoId = $(videoObj).attr('id');
        //console.log(videoId)
        var path = '//vimeo.com/api/v2/video/' + videoId + '.json?callback=?';
        //console.log(path);
        $.getJSON(path, { format: "json" }, function (data) {

            //$('#' + videoId).css('background-image', 'url(' + data[0].thumbnail_large + ')');
            $(videoObj).css('background-image', 'url(' + data[0].thumbnail_large + ')');
        })
    }, ttime)
}

videoOpen = function (vobj) {
    vobj = $(vobj);
    vsrc = vobj.attr("rel");

    parent.$.fancybox({
        minWidth: 600,
        minHeight: 400,
        maxWidth: 600,
        maxHeight: 400,
        autosize: true,
        padding: 0,
        href: vsrc,
        type: 'iframe',
        iframe: {
            scrolling: 'no',
            preload: true
        },
        afterShow: function () {
            $('.fancybox-close').css('bottom', '-40px')
            $('.fancybox-close').css('right', '-10px')
        },
        helpers: {

            overlay: {
                css: {
                    'background': 'rgba(255, 255, 255, 0.9)'
                }
            }
        }


    });

}

getProjects = function () {
    $('div.projectsTitle').click(function () {
        clearTimeout(changeHomeList)
        firstclicked = 1
        closeprojects()
        changeHList($(this))
    })
}

changeHList = function (hobj) {
    $('div.projectsTitle').each(function () { $(this).find('span').removeClass('active'); $(this).css('background-color', $(this).attr('rel')); $(this).css('color', '#fff'); $(this).css('background-image', 'url(/images/arrow_title.png)') })
    hobj.css('background-color', '#fff');
    hobj.css('color', hobj.attr('rel'));
    firstload = hobj.index('div.projectsTitle')
    hobj.css('background-image', 'url(/images/arrow_title_' + firstload + '.png)')
    hobj.find('span').addClass('active');
    gtId = hobj.attr('id');
    gtId = gtId.substring(gtId.indexOf("_") + 1)
    loadProjects(gtId, 'type')
}

loadProjects = function (pref, mode) {

    clearTimeout(changeHomeList)

    $('div.homeProjects').removeClass('noinfo')
    $('div.homeProjects img.arrow').remove()
    $('div.homeProjects div.dots').remove()
    $('div.homeProjects div.projectsList').stop().fadeOut(300, function () {

        $('div.homeProjects div.projectsList').html('')
        gtUrl = "/project/getProjects_list.asp?load=" + pref + "&mode=" + mode + "&area=" + selectedArea + "&ssid=" + Math.floor((Math.random() * 111111) + 1)

        if ($('#hdl_' + mode + '_' + pref).size() == 0) {
            $('<div id="hdl_' + mode + '_' + pref + '" style="display:none;opacity:0.0"></div>').appendTo($('body'))
        }

        cacheObj = $('#hdl_' + mode + '_' + pref)
        //VB:Prevengo sempre il caching dell'oggetto

        if (cacheObj.html().length > 1 && mode == "type" && 1 != 1) {
            schedeloaded = 0;
            loadHomeList(mode);
            $('div.homeProjects div.projectsList img.tooltip').tooltipster({
                contentCloning: true,
                contentAsHTML: true
            });
        } else {
            //return;
            //console.log("before call");
            $.ajax({
                url: gtUrl,
                success: function (data) {
                    schedeloaded = 0;
                    //console.log(data);
                    cacheObj.html(data);
                    loadHomeList(mode);
                    $('div.homeProjects div.projectsList img.tooltip').tooltipster({
                        contentCloning: true,
                        contentAsHTML: true
                    });
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    console.log('error');
                }
            });
        }
    })
}

loadHomeList = function (mode) {
    //console.log("qui");
    //$('div.homeProjects').css('display', 'inline')
    $('div.pText').html('')
    $('div.iContainer').remove()
    $('div.iContainer').remove()
    $('div.homeProjects div.scrollProjects').css('left', '0px')
    $('div.homeProjects div.projectsList').html(cacheObj.html());

    $("div.homeProjects div.scrollProjects").html($("div.homeProjects div.scrollProjects div.p_list").sort(function () {
        return Math.random() - 0.5;
    }));

    $('div.p_list div p.descx span').hyphenate(langHype);
    $('div.p_list div p.descx span strong').hyphenate(langHype);

    $('div.homeProjects div.projectsList').fadeIn()

    if ($('body').hasClass('home') && firstclicked == 0 && mode == 'type') {

        changeHomeList = setTimeout(function () {
            firstload++
            if (firstload >= $('div.projectsTitle').size()) firstload = 0
            nobj = $('div.projectsTitle').eq(firstload)
            changeHList(nobj)
        }, 8000)
    }

    $("div.homeProjects div.projectsList div.p_list div.pic, div.homeProjects div.projectsList div.p_list div.text").click(function () {
        getPid = $(this).parent().attr('id')
        getPlink = $(this).parent().attr('rel')
        getPid = getPid.substring(2)
        document.location = "/?progetti/" + getPid + "/" + getPlink
    })


    numprojects = $('div.homeProjects div.projectsList div.p_list').size()
    //console.log("numprojects: " + numprojects)
    //console.log("$('div.homeProjects div.projectsList').width(): " + $('div.homeProjects div.projectsList').width())
    //console.log("$('div.homeProjects div.projectsList div.p_list').eq(0).width()" + $('div.homeProjects div.projectsList div.p_list').eq(0).width())
    perline = parseInt($('div.homeProjects div.projectsList').width() / $('div.homeProjects div.projectsList div.p_list').eq(0).width())
    //console.log("perline:" + perline)

    if (numprojects > perline) {
        if (ismobile) {
            $("div.homeProjects div.scrollProjects").swipe({
                swipeLeft: function (event, direction, distance, duration, fingerCount) {
                    moveHomeProjects(1, perline, 0)
                },
                swipeRight: function (event, direction, distance, duration, fingerCount) {
                    moveHomeProjects(-1, perline, 0)
                },
                threshold: 50
            })

            $(".homeProjects div.p_list").swipe({
                tap: function (event, target) {
                    getPid = $(this).attr('id')
                    getPlink = $(this).attr('rel')
                    getPid = getPid.substring(2)
                    document.location = "/?progetti/" + getPid + "/" + getPlink
                }
            })
        }
        if (perline == 0)
            perline = 1;
        numpages = (Math.ceil(numprojects / perline))
        //console.log("numprojects: " + numprojects + " perline: " + perline + " numpages: " + numpages)
        $('<img class="arrow" src="/images/arrow_next_home.png" onclick="moveHomeProjects(1,' + perline + ',0)"/>').appendTo($('div.homeProjects'))
        $('<img class="arrow backarrow" src="/images/arrow_back_home.png" onclick="moveHomeProjects(-1,' + perline + ',0)"/>').appendTo($('div.homeProjects'))
        $('div.homeProjects div.scrollProjects').width(($('div.homeProjects div.projectsList div.p_list').eq(0).width() + 8) * $('div.homeProjects div.projectsList div.p_list').size())
        $('<div class="dots"><div></div></div>').appendTo($('div.homeProjects'))
        //console.log(numpages);
        for (x = 0; x < numpages; x++) {
            //$('<span onclick="moveHomeProjects(' + x + ',' + perline + ',1)"></span>').appendTo($('div.homeProjects div.dots div'))
        }


        $('<tag><t id="page">1</t><pag>&nbsp;/&nbsp;' + numpages + '</pag></tag>').appendTo($('div.homeProjects div.dots div'));
        //$('div.homeProjects div.dots div > span').eq(0).addClass('active');
    }

    $('div.projectsList').fadeIn(100, function () {
        schedePictures()
    })

    if ($('div.projectsList div.catInfo div').size() == 0) {
        $('div.scrollProjects').css('top', '0px')
        $('div.homeProjects').addClass('noinfo')
        console.log('entra qui');
    }

    if (!$('body').hasClass('home')) {
        $('div.arrow span').remove()
        $('div.pContainer').css('margin-top', '-250px')
        if ($('body').hasClass('progetti')) {
            $('div.pContainer').css('margin-top', '-200px')
            $('div.pText').css('background', 'transparent')
        }
    }

}


moveNews = function (mode, rsize, mm, objindx) {
    newscontainer = $('div.homeNews').eq(objindx)
    var offset = 0;
    if (newscontainer.find('div.newsScroller').prev().attr('id') == 'fbPage') {
        offset = newscontainer.width()/2; 
    }
    newsobjects = newscontainer.find('div.newsScroller > div')
    newsscroller = newscontainer.find('div.newsScroller')
    wScheda = newsobjects.eq(0).width() + 9;
    maxLeft = (wScheda * newsobjects.size()) * -1 + (wScheda * rsize)
    moveTot = wScheda * (rsize)
    actleft = newsscroller.position().left

    if (mm == 0) {
        newleft = actleft + (moveTot * mode) * -1
    }
    if (mm == 1) {
        newleft = parseInt(newsobjects.eq(mode * rsize).position().left) * -1;
    }

    //if (newleft > 0) newleft = 0
    if (newleft > 475) newleft = 475
    if (newleft < maxLeft) newleft = maxLeft

    actPage = (Math.ceil(newleft / moveTot * -1))
    if (actPage < 0) actPage = actPage * -1

    newscontainer.find('span').removeClass('active');
    newscontainer.find('div.dots div > span').eq(actPage).addClass('active');
    //console.log ( "newleft: " + newleft ) 
    //console.log ( "left: " +  (newleft + offset )) 
    newsscroller.stop().animate({ left: newleft + 'px' }, 800, function () {
    })
}


moveHomeProjects = function (mode, rsize, mm) {
    clearTimeout(changeHomeList)
    wScheda = $('div.projectsList div.p_list').eq(0).width() + 8;
    maxLeft = (wScheda * $('div.projectsList div.p_list').size()) * -1 + (wScheda * rsize)
    moveTot = wScheda * (rsize)
    actleft = $('div.scrollProjects').position().left

    if (mm == 0) {
        newleft = actleft + (moveTot * mode) * -1
    }
    if (mm == 1) {
        newleft = parseInt($('div.projectsList div.p_list').eq(mode * rsize).position().left) * -1;
    }

    if (newleft > 0) newleft = 0
    if (newleft < maxLeft) newleft = maxLeft

    actPage = (Math.ceil(newleft / moveTot * -1))
    if (actPage < 0) actPage = actPage * -1

    $('div.homeProjects div.dots div > span').removeClass('active');
    $('div.homeProjects div.dots div > span').eq(actPage).addClass('active');
    numActPage = actPage + 1;
    if (actPage > 0) numActPage = actPage + 1;
    console.log(numActPage);

    $('div.homeProjects div.dots div t#page').html(numActPage);

    setTimeout("schedePictures()", 200)
    $('div.homeProjects div.scrollProjects').stop().animate({ left: newleft + 'px' }, 800, function () {
    })
}

setScroll = function () {
    $(window).bind('scroll', function () {
        if ($('div.projectsList div.p_list').size() > 0) schedePictures()
        return false;
    });

}

adaptSize = function (add) {
    minDoc = $('body').innerHeight() - $('#footer').height();
    minWin = $(window).height() - $('#header').height() - $('#footer').height();
    if (!$('body').hasClass('home')) $('.pContainer').css('min-height', (minWin) + 'px')
}

setSubs = function () {
    $('ul.mainMenu li').bind('click', function (e) {
        e.preventDefault();
        gtId = $(this).attr('id');
        gtId = gtId.substring(2)
        makeSub(gtId, 0)
    })
}

makeSub = function (gtId, mode) {
    if (actSMen != gtId) {
        actSMen = gtId;
        s = $('#m_' + gtId)
        if (mode == 1) men_open = gtId

        $('div.childmenu').remove();
        $('ul.mainMenu li').not('#m_' + gtId).removeClass('innerCurrent')

        $.ajax({
            url: "/incs/getSubs.asp?load=" + gtId,
            context: document.body,
            success: function (data) {
                gtSbs = data;

                s.addClass('innerCurrent')

                if (gtSbs.length == 0) {
                    findLink = s.find('a').attr('href')
                    if (document.location.href.indexOf(findLink) == -1) document.location = findLink;
                }

                if (gtSbs.length > 0) {
                    gtload = parseInt(gtSbs.substring(0, gtSbs.indexOf('#')))
                    gtSbs = gtSbs.substring(gtSbs.indexOf('#') + 1)
                    gtSbs = gtSbs.split('$');
                    adSb = '';
                    adddiv = $('<div class="childmenu"><div class="bg"></div><ul></ul></div>').appendTo($('#header'))
                    for (x = 0; x < gtSbs.length; x++) {
                        gtLink = gtSbs[x].split('|');
                        lRef = gtLink[0]
                        if (document.location.href.indexOf("?" + lRef + "/") != -1) lRef = lRef + '" class="subCurrent';
                        adSb += '<li id="s_' + lRef + '"><a href="' + gtLink[2] + '">' + gtLink[1] + '</a></li>';
                    }
                    $('div.childmenu ul').html(adSb)
                    child_w = $('div.childmenu').innerWidth()
                    newLeft = s.offset().left - $('#centered').offset().left - (child_w / 2) + (s.innerWidth() / 2)
                    checkOff = child_w + newLeft - $('#centered').width()
                    if (checkOff > 0) {
                        newLeft = newLeft - (checkOff - 11)
                        $('div.childmenu ul li:last').css('padding-right', '0px')
                    }
                    newLeft = newLeft - 20;
                    //$('div.childmenu').css('left', newLeft + 'px')
                    $('div.childmenu').stop().fadeIn(100)

                }
            }
        })
    }
}

clearMenu = function () {
    clearTimeout(hideSubs)
    $('ul.mainMenu li.innerCurrent').removeClass('innerCurrentH')
    $('div.childmenu').fadeOut(200, function () {
        $('div.childmenu').remove(); actSMen = 0;
        $('ul.mainMenu li').removeClass('overCurrent')
        if (men_open != 0) setTimeout(function () { makeSub(men_open, 1) }, 300);
    })
}
setNotifLang = function (field, obj) {
    gtval = 'it';
    gtval = $(obj).find(':selected').attr('rel')

    var data1 = {
        setval: gtval,
        setfield: field
    };
    $.ajax({
        type: "POST",
        url: "/actions/update_notif_lang.asp",
        data: data1,
        timeout: 6000,
        success: function (msg) {

            //decidere cosa fare quando viene impostato il campo 


        }
    });
}
setNotifica = function (field, obj) {

    gtval = "False"
    if (obj.is(':checked')) gtval = "True"

    var data1 = {
        setval: gtval,
        setfield: field
    };


    $.ajax({
        type: "POST",
        url: "/actions/update_notifica.asp",
        data: data1,
        timeout: 6000,
        success: function (msg) {

            if (field == "LO_no_notifica" && gtval == "True") $('p.notifyOptions').css('opacity', '0.0')
            if (field == "LO_no_notifica" && gtval == "False") $('p.notifyOptions').css('opacity', '1.0')


        }
    });


}

viewSlide = function (slideRef) {
    $('div.normalPage .slide').not('.slide_' + slideRef).slideUp();
    $('.slide_' + slideRef).slideDown()
}

viewSection = function (sectionRef) {
    actSection = $('div.faq_section').eq(sectionRef)
    $('div.faq_section').not(actSection).stop().slideUp();
    actSection.stop().slideDown(300, function () {
        $('html, body').animate({ scrollTop: (actSection.offset().top - 80) }, 400)
    })
}

getNation = function (objget) {
    gtUrl = "/actions/get_nations.asp?ssid=" + Math.floor((Math.random() * 111111) + 1)
    $.ajax({
        url: gtUrl,
        success: function (data) {

            $(objget).html(data)

            $(objget).fadeIn()
            $(objget).focus()

            if (document.createEvent) {
                gtindex = $(objget).index('select')
                var element = $("select")[gtindex], worked = false;
                var e = document.createEvent("MouseEvents");
                e.initMouseEvent("mousedown", true, true, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
                worked = element.dispatchEvent(e);
            }
        }
    })

}

setNation = function (objget, destinput, olderinput) {
    gtVal = objget.val()
    $('input[name="' + destinput + '"]').val(gtVal)
    $('input[name="' + olderinput + '"]').val(objget.find("option:selected").text())
    objget.fadeOut()
}

deleteAccount = function () {

    $('#cancelAccount').submit(function (e) {
        e.preventDefault();
        $.ajax({
            type: "POST",
            url: "/actions/cancel_profile.asp",
            data: $("#editProfile").serialize(),
            timeout: 6000,
            success: function (msg) {
                if (msg == 'OK') {
                    $('#areaCancel').html('<p>' + str_confirmemail_sent + '</p>')
                } else {
                    $('<p>' + str_generic_error + '</p>').appendTo($('#areaCancel'))
                }
            }
        });
    });
    $('.profileData').css('display', 'none')
    $('#areaNotifica').css('display', 'none')
    $('#areaPassword').css('display', 'none')
    $('#areaEmail').css('display', 'none')
    $('#areaCancel').css('display', 'inline')
    $('html, body').animate({ scrollTop: $('#areaDati').offset().top - 150 }, 300)


}

editProfile = function () {
    $('#editProfile').submit(function (e) {
        e.preventDefault();
        complete = 1;
        $('#editProfile').find('input.ob').each(function () {
            gtVal = $(this).val();
            if (gtVal.length < 1) {
                $(this).css('border', 'solid 1px #ff0000')
                complete = 0;
            }

        })

        gtDate = $('input[name=DT_data_nascita]').val();
        gtCap = $('input[name=TA_cap]').val();
        gtTel = $('input[name=TA_telefono]').val();

        if (gtCap.length < 4) {
            $('input[name=TA_cap]').css('border', 'solid 1px #ff0000')
            complete = 0;
        }

        if (gtTel.length < 9) {
            $('input[name=TA_telefono]').css('border', 'solid 1px #ff0000')
            complete = 0;
        }


        var date_regexDt = /^(0[1-9]|1\d|2\d|3[01]).(0[1-9]|1[0-2]).(19|20)\d{2}$/;

        if (!date_regexDt.test(gtDate)) { $('input[name=DT_data_nascita]').css('border', 'solid 1px #ff0000'); complete = 0; } else {
            var t = gtDate.split('.');
            var m = parseInt(t[1], 10);
            var d = parseInt(t[0], 10);
            var y = parseInt(t[2], 10);
            var date = new Date(t[2], t[1] - 1, t[0]);
            checkD = (date.getFullYear() == y && date.getMonth() + 1 == m && date.getDate() == d);
            if (!checkD) {
                $('input[name=DT_data_nascita]').css('border', 'solid 1px #ff0000'); complete = 0;
            } else {
                if (!oldIeBrowser) {
                    getAge = _calculateAge(date);
                    if (getAge < 18) {
                        var r = confirm(str_age_min);
                        if (r == true) $('input[name=DT_data_nascita]').focus()
                        $('input[name=DT_data_nascita]').css('border', 'solid 1px #ff0000'); complete = 0;
                    }
                }
            }
        }



        if (complete == 0) {
            return;
        }

        $.ajax({
            type: "POST",
            url: "/actions/edit_profile.asp",
            dataType: 'html',
            data: $("#editProfile").serialize(),
            timeout: 6000,
            success: function (msg) {
                if (msg == 'OK') {
                    $(window).scrollTop(0)
                    $('#areaDati').html('<p>' + str_data_saving + '</p>')
                    setTimeout(function () { document.location = "/profilo/" }, 2000)
                }
            },
            error: function (msg) { alert(str_generic_error); return; }

        });
        return false;


    })

    $('.profileData').css('display', 'none')
    $('#areaNotifica').css('display', 'none')
    $('#areaPassword').css('display', 'none')
    $('#areaEmail').css('display', 'none')
    $('#areaDati').css('display', 'inline')
    $('html, body').animate({ scrollTop: $('#areaDati').offset().top - 150 }, 300)


}

function _calculateAge(birthday) {
    if (!oldIeBrowser) {
        var ageDifMs = Date.now() - birthday.getTime();
        var ageDate = new Date(ageDifMs);
        return Math.abs(ageDate.getUTCFullYear() - 1970);
    } else { return 18; }
}


function isValid(input) {
    if (input.indexOf(' ') != -1) {
        return false;
    }

    var reg = /^[^%\s]{6,}$/;
    var reg2 = /[a-z]/;
    var reg3 = /[A-Z]/;
    var reg4 = /[0-9]/;
    return reg.test(input) && reg2.test(input) && reg3.test(input) && reg4.test(input);
}

editNotifLanguage = function () {

}
editEmail = function () {
    $('#editMail').submit(function (e) {
        e.preventDefault();
        gtval = $('input[name="email"]').val()

        var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;

        if (!regex.test(gtval)) {
            $('<p class="erm">' + str_email_unvalid + '</p>').appendTo($('#areaEmail'))
            return;
        }

        $('p.erm').remove()
        var data1 = {
            email: gtval
        };

        $.ajax({
            type: "POST",
            url: "/actions/edit_email.asp",
            data: data1,
            timeout: 6000,
            success: function (msg) {
                if (msg == 'OK') $('#areaEmail').html('<p>' + str_email_modified + '<br/>' + str_confirmemail_sent + '</p>')
                if (msg == 'Exist') $('<p class="erm">' + str_email_exist + '</p>').appendTo($('#areaEmail'))
            }
        });
        return false;

    })

    $('.profileData').css('display', 'none')
    $('#areaNotifica').css('display', 'none')
    $('#areaPassword').css('display', 'none')
    $('#areaEmail').css('display', 'inline')
    $('#areaEmailr').css('display', 'none')
    $('#areaDati').css('display', 'none')
    $('html, body').animate({ scrollTop: $('#areaEmail').offset().top - 150 }, 300)

}

editEmailR = function () {
    $('#editMailr').submit(function (e) {
        e.preventDefault();
        gtval = $('input[name="emailr"]').val()

        var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;

        if (!regex.test(gtval)) {
            $('<p class="erm">' + str_email_unvalid + '</p>').appendTo($('#areaEmailr'))
            return;
        }

        $('p.erm').remove()
        var data1 = {
            email: gtval
        };

        $.ajax({
            type: "POST",
            url: "/actions/edit_email_r.asp",
            data: data1,
            timeout: 6000,
            success: function (msg) {
                if (msg == 'OK') $('#areaEmailr').html('<p>' + str_email_recovery + '</p>')
                if (msg == 'Exist') $('<p class="erm">' + str_email_exist + '</p>').appendTo($('#areaEmailr'))
            }
        });
        return false;


    })

    $('.profileData').css('display', 'none')
    $('#areaNotifica').css('display', 'none')
    $('#areaPassword').css('display', 'none')
    $('#areaEmailr').css('display', 'inline')
    $('#areaEmail').css('display', 'none')
    $('#areaDati').css('display', 'none')
    $('html, body').animate({ scrollTop: $('#areaEmail').offset().top - 150 }, 300)

}

editPassword = function () {
    $('#editPassword').submit(function (e) {
        e.preventDefault();
        $('p.erm').remove()

        if (!isValid($('input[name="pass2"]').val())) {
            $('<p class="erm">' + str_pass_min + '</p>').appendTo($('#areaPassword'))
            return
        }

        var data1 = {
            pass1: $('input[name="pass1"]').val(),
            pass2: $('input[name="pass2"]').val(),
            pass3: $('input[name="pass3"]').val()
        };

        $.ajax({
            type: "POST",
            url: "/actions/edit_password.asp",
            data: data1,
            timeout: 6000,
            success: function (msg) {
                if (msg == 'OK') $('#areaPassword').html('<p>' + str_pass_modified + '</p>')
                if (msg == 'Confirm') $('<p class="erm">' + str_pass_conf_err + '</p>').appendTo($('#areaPassword'))
                if (msg == 'Pass') $('<p class="erm">' + str_pass_err + '</p>').appendTo($('#areaPassword'))

            }
        });
        return false;
    })

    $('.profileData').css('display', 'none')
    $('#areaNotifica').css('display', 'none')
    $('#areaPassword').css('display', 'inline')
    $('#areaEmail').css('display', 'none')
    $('#areaDati').css('display', 'none')
    $('html, body').animate({ scrollTop: $('#areaPassword').offset().top - 150 }, 300)
}

closeEditProfile = function () {
    $('#areaNotifica').css('display', 'inline')
    $('#areaDati').css('display', 'none')
    $('.profileData').css('display', 'inline')
}


checkNavigator = function () {
    isiphone = /iphone/.test(clientNavigator);
    isipad = /ipad/.test(clientNavigator);
    isandroid = /android/.test(clientNavigator);
    ischrome = /chrome/.test(clientNavigator);
    isfirefox = /firefox/.test(clientNavigator);
    ismsie = /msie/.test(clientNavigator);
    ismsie11 = /trident/.test(clientNavigator);
    msphone = /iemobile/.test(clientNavigator);
    msphone1 = /Windows Phone/.test(clientNavigator);
    if (msphone || msphone1) { wphone = true; ismsie = true; }
    if (ismsie11) { ismsie = true; }

    if (isiphone || isandroid || isipad || wphone) {
        ismobile = true;
        isdesktop = false;

        $('div.homeNews > div').swipe({
            swipeLeft: function (event, direction, distance, duration, fingerCount) {
                gtObj = $(this)
                objindex = gtObj.parent().index('div.homeNews')
                bopgs = gtObj.parent().attr("data-pages")
                moveNews(1, bopgs, 0, objindex)
            },
            swipeRight: function (event, direction, distance, duration, fingerCount) {
                gtObj = $(this)
                objindex = gtObj.parent().index('div.homeNews')
                bopgs = gtObj.parent().attr("data-pages")
                moveNews(-1, bopgs, 0, objindex)

            },
            threshold: 50
        })


        $("div.homeNews div.newsScroller > div").swipe({
            tap: function (event, target) {
                eval($(this).find('div.nContent').attr('onclick'))
            }
        })




    }
}



setHype = function () {

    if (!oldIeBrowser) {
        $.getScript("/js/" + langHype + ".js", function () {
            $('.normalPage p').hyphenate(langHype);
        });
    }
}



refreshCaptcha = function () {
    $('.cptch').attr('src', '/images/vuoto.gif')
    setTimeout(function () { $('.cptch').attr('src', '/img_captcha.asp?ssid=' + Math.floor((Math.random() * 99999) + 1)) }, 200)
}


parentEdit = function (eq) {


    parent.$('.edit').eq(eq).trigger('click');

}

make_edit = function (mode) {
    if (mode != 2) $('div.info_p', parent.document).css('display', 'none')
    if (mode == 2) $('div.info_p', parent.document).css('display', 'inline')

    $('div.myprojectsFrame', parent.document).css('height', '1px')
    $('div.pText', parent.document).css('height', '50px')
    closeprojectForm()
    $("div.myprojectsFrame iframe", parent.document).delay(300).animate({ opacity: 1 }, 400)

    $('div.addbottom', parent.document).html('<div class="pp" style="position:absolute; left:170px; top:8px;"></div><div class="pr" style="position:absolute; right:0px">' + $('span.btn').html() + '</div>')
    $('span.btn').html('')
    $('div.ppath').prependTo($('div.addbottom div.pp', parent.document))
}

make_editor = function (obj) {
    obj.tinymce({
        script_url: '/admin/jscripts/tiny_mce3.5.10/tiny_mce.js',
        translate_mode: true,
        language: "it",
        width: 549,
        height: 180,
        theme: "advanced",
        plugins: "inlinepopups,paste",
        theme_advanced_buttons1: "bold,italic,link,unlink",
        theme_advanced_buttons2: "",
        theme_advanced_buttons3: "",
        theme_advanced_toolbar_location: "bottom",
        theme_advanced_toolbar_align: "left",
        theme_advanced_statusbar_location: "none",
        theme_advanced_resizing: false,
        invalid_elements: "span,div",
        paste_text_sticky: true,
        setup: function (ed) {
            ed.onInit.add(function (ed) {
                ed.pasteAsPlainText = true;
            });
        }

    });
}

delParagraph = function (bref) {
    gtref = $('#edRef').val()

    if (confirm(str_par_del)) {
        var data1 = {
            load: gtref,
            refb: bref
        };

        $.ajax({
            type: "POST",
            url: "/actions/del_paragraph.asp",
            data: data1,
            timeout: 6000,
            success: function (msg) {
                loadParagraphs()
            }
        });
    }
}

noEditParagraph = function () {
    $('input.dd1').val($('input.dd1').attr('rel'))
    $('#title').val('')
    tinyMCE.activeEditor.setContent('');
    $('#embd').val('')
    $('#editRef').val('')
    $('.fUp').html('SCEGLI FILE')
    $('.fUp2').html('IMMAGINE')
    $('.fUp1').css('display', 'none')
    $('#cifra_').val('')
    $('#cifra_a').val('')
    makeSortedParagraphs()

    closeprojectForm()
}

editParagraph = function (bref) {
    gtref = $('#edRef').val()
    $('p.dispError').remove()

    if ($('.sortPacket').size() > 0) $("div.showPackets").sortable("destroy");
    $("div.showPackets").removeClass("sortPacket")
    $('div.ordP').css('cursor', 'default')


    sturl = "/actions/edit_paragraph.asp?load=" + gtref + "&refb=" + bref;


    $.ajax({
        url: sturl,
        dataType: 'json',
        success: function (data) {
            $('input.dd1').val($('input.dd1').attr('alt'))
            $('.fUp').html('CAMBIA FILE')
            $('.fUp2').html('IMMAGINE')
            $('.fUp1').css('display', 'inline')

            $('#editRef').val(bref)
            pTit = data.title

            pText = data.text
            pEmbed = data.embed
            $('#title').val(pTit)
            tinyMCE.activeEditor.setContent(pText);
            $('#embd').val(pEmbed)
        },
        error: function () { $('#title').val(str_no_elment) }
    });
    return;

}

editBenefit = function (bref) {
    gtref = $('#edRef').val()

    url = "/actions/edit_benefit.asp?load=" + gtref + "&refb=" + bref;

    $.getJSON(url, function (data) {
        $('input.dd1').val($('input.dd1').attr('alt'))

        $('#editRef').val(bref)
        pTit = data.title
        pText = data.text
        pVal = data.val1
        pVal1 = data.val2
        $('#title').val(pTit)
        tinyMCE.activeEditor.setContent(pText);
        $('#cifra_').val(pVal)
        $('#cifra_a').val(pVal1)

    });
    return;

}

loadprojectForm = function () {
    $('input.adbt').css('display', 'none')
    $('div.projectForm').fadeIn(100, function () {
        $('div.myprojectsFrame', parent.document).css('height', $(document).innerHeight() + 20 + 'px')
        $('div.pText', parent.document).css('height', $('div.myprojectsFrame', parent.document).height() + $('div.myprojectsFrame', parent.document).position().top + 100 + 'px')
        $('div.pContainer', parent.document).css('height', $('div.pText', parent.document).height() + 160)
        $('html, body', parent.document).animate({ scrollTop: $(document).innerHeight() }, 400)
        $('#title').focus();
    })
}

closeprojectForm = function () {
    $('input.adbt').css('display', 'inline')
    $('div.projectForm').css('display', 'none')
    $('.fUp1').css('display', 'none')

    $('div.myprojectsFrame', parent.document).css('height', $(document).innerHeight() + 20 + 'px')
    $('div.pText', parent.document).css('height', $('div.myprojectsFrame', parent.document).height() + $('div.myprojectsFrame', parent.document).position().top + 100 + 'px')
    $('div.pContainer', parent.document).css('height', $('div.pText', parent.document).height() + 160)
    parent.adaptSize()
}

makeCapthca = function () {
    $('input[name="cptch"]').keyup(function () {
        gtval1 = $(this).val()
        $(this).removeClass('err')

        $.ajax({
            url: "/incs/capthca_check.asp?val=" + gtval1 + "&ssid=" + Math.floor(Math.random() * 99999),
            success: function (msg) {
                if (msg == "OK") {
                    $('.chch').attr('src', '/images/check_ove.png')
                    $('.chch').addClass("ok")
                } else {
                    $('.chch').attr('src', '/images/check.png')
                    $('.chch').removeClass("ok")
                    if (gtval1.length > 3) $('input[name="cptch"]').addClass('err')

                }
            }
        })
    })

    $('form.cForm').submit(function (e) {
        e.preventDefault()
        form_submit = $(this)
        vals = form_submit.serialize()
        complete = 1
        var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;

        form_submit.find('input.obl,textarea.obl,select.obl').each(function () {
            $(this).removeClass('err')
            if ($(this).val().length < 1) { complete = 0; $(this).addClass('err') }

            if ($(this).hasClass('eml') && !regex.test($(this).val())) { complete = 0; $(this).addClass('err') }

        })

        if (!$('.chch').hasClass('ok')) {
            complete = 0;
            $('input[name="cptch"]').addClass('err')
        }

        if (complete == 0) {
            return
        }

        $.ajax({
            type: "POST",
            url: "/send_form.asp",
            data: vals,
            dataType: "html"
        }).done(function (msg) {

            if (msg.indexOf("SUCCESS#") != -1) {
                $('.fContain').html('<p class="testo" style="margin-left:0px; width:200px; text-align:left">' + msg.substring(8) + '</p>');
                $('html, body').delay(100).animate({ scrollTop: 0 }, 400)
            } else {
                $('.fContain').html('<p class="testo" style="margin-left:0px">Errore durante l\'invio, si prega di provare più tardi.</p>');
            }
        });


        return false
    })
}

viewReason = function (tx, ob) {
    $('<div class="reason">' + tx + '</div>').appendTo($('body'));
    $('div.reason').css('left', ob.offset().left - 10 + 'px')
    $('div.reason').css('top', ob.offset().top - 18 + 'px')
    $('div.reason').fadeIn()
    $('div.reason').hover(function () { void (0) }, function () { $('div.reason').remove() })
}

updEditColor = function (gtCol, oind) {
    $('#maincat', parent.document).html(pcat)
    $('#maincolor', parent.document).html(gtCol)
    $('.pButton', parent.document).not('.fin').removeClass('a0')
    $('.pButton', parent.document).not('.fin').removeClass('a2')
    $('.pButton', parent.document).not('.fin').removeClass('a3')
    $('.pButton', parent.document).not('.fin').removeClass('a1')
    $('.pButton', parent.document).not('.fin').removeClass('active')
    $('.pButton', parent.document).not('.fin').addClass('a' + pcat)
    $('h1', parent.document).css('color', gtCol)
    $('h2', parent.document).css('color', gtCol)
    $('h3', parent.document).css('color', gtCol)
    $('.pButton', parent.document).eq(oind).removeClass('a' + pcat)
    $('.pButton', parent.document).eq(oind).addClass('active')
    $('.pButton', parent.document).eq(oind).css('color', gtCol)
    gtactI = $('.pButton', parent.document).eq(oind).find('img')
    gtSrc = gtactI.attr('src')
    gtSrc = gtSrc.replace('0.png', pcat + '.png')
    gtSrc = gtSrc.replace('1.png', pcat + '.png')
    gtSrc = gtSrc.replace('2.png', pcat + '.png')
    gtSrc = gtSrc.replace('3.png', pcat + '.png')
    gtactI.attr('src', gtSrc)


    $('.pButton', parent.document).not('.fin').each(function () {
        gtRel = $(this).find('img').attr('rel')
        gtRel = gtRel.replace('0.png', pcat + '.png')
        gtRel = gtRel.replace('1.png', pcat + '.png')
        gtRel = gtRel.replace('2.png', pcat + '.png')
        gtRel = gtRel.replace('3.png', pcat + '.png')
        $(this).find('img').attr('rel', gtRel)
    })
}

abortUpload = function (obj1, obj2) {
    jqXHR.abort();
    obj1.fadeIn(100);
    obj2.parent().fadeOut(200);
}

getFacebookPosts = function () {
    if ($('div.testimonial').size() > 0) {
        pubDest = 2

        fUrl = "/incs/getTestimonials.asp?jsoncallback=?&ssid=" + Math.floor((Math.random() * 111111) + 1);
        $.ajax({
            type: "GET",
            url: fUrl,
            crossDomain: true,
            timeout: 6000,
            dataType: 'jsonp',
            success: function (json) {
                var len = json.length;

                for (var i = 0; i < len; i++) {
                    jsonEntry = json[i];
                    feedMsg = jsonEntry.testimonial.message;
                    feedFrom = jsonEntry.testimonial.name;
                    if (feedMsg.length > 190) feedMsg = feedMsg.substring(0, 190) + " ..."
                    $('div.testimonial > div').eq(pubDest).html('<div>"' + feedMsg + '"<p>' + feedFrom + '</p><img src="/images/tes.png"/></div>')
                    $('div.testimonial > div').eq(pubDest).fadeIn()
                    pubDest--;

                }


                setTimeout(function () {
                    fUrl = "/incs/getFBFeed.asp?jsoncallback=?"

                    $.ajax({
                        type: "GET",
                        url: fUrl,
                        crossDomain: true,
                        timeout: 6000,
                        dataType: 'jsonp',
                        success: function (json) {
                            var len = json.length;
                            for (var i = 0; i < len; i++) {
                                if (pubDest >= 0) {

                                    jsonEntry = json[i];
                                    feedMsg = jsonEntry.message;
                                    feedFrom = jsonEntry.from.name;

                                    if (typeof feedMsg === "undefined" || feedMsg.indexOf('http:') != -1) {

                                    } else {
                                        if (feedMsg.length > 190) feedMsg = feedMsg.substring(0, 190) + " ..."
                                        $('div.testimonial > div').eq(pubDest).html('<div>"' + feedMsg + '"<p>' + feedFrom + '</p></div><a href="https://www.facebook.com/pages/Progettiamoch/1416183075301590" target="_blank"><img src="/images/fbs.png"/></a>')
                                        $('div.testimonial > div').eq(pubDest).fadeIn()

                                        pubDest--;
                                    }
                                }
                            }

                        }
                    })
                }, 300)
            }
        })
    }
}

loadPieChart = function (firstVal, secondVal, thirdVal) {
    nocolor = "transparent"
    if (oldIeBrowser) nocolor = "#ffffff"
    var optionsDoug = { percentageInnerCutout: 80, segmentStrokeWidth: 0, segmentShowStroke: false };
    var doughnutData = [{ value: firstVal, color: "#9ba1b3" }, { value: secondVal, color: "#292f3a" }, { value: thirdVal, color: nocolor }];
    setTimeout(function () {
        var myDoughnut = new Chart(document.getElementById("canvas").getContext("2d")).Doughnut(doughnutData, optionsDoug);
    }, 900)
}

hideHome = function () {
    if ($('body').hasClass('home')) {
        $('.pText').css('display', 'inline');
        $('.pContainer').css('margin-top', '-1px');
        $('div.iContainer').css('margin-top', '18px');
        $('.homeSlideshow').css('display', 'none');
        $('.homeProjects').css('display', 'none');
        $('.testimonial').css('margin-top', '120px');
        $('.searchMenu span').remove()

        $('div.iContainer').css('display', 'inline');
        minWin = $(window).height() - $('#header').height() - $('#footer').height();
        $('.pContainer').css('min-height', (minWin) + 'px')
    }
}

checkPrefix = function (destObjt, val) {
    if (val.length > 0) {
        val = parseInt(val)
        if (val != 237) {
            if (val == 80) adval = "+49"
            if (val == 73) adval = "+33"
            if (val == 104) adval = "+39"
            if (val == 203) adval = "+41"
            if (val == 121) adval = "+423"
            if (val == 14) adval = "+43"
            if (val == 21) adval = "+32"
            if (val == 38) adval = "+1"
            if (val == 56) adval = "+357"
            if (val == 57) adval = "+420"
            if (val == 58) adval = "+45"
            if (val == 72) adval = "+358"
            if (val == 83) adval = "+30"
            if (val == 102) adval = "+353"
            if (val == 123) adval = "+352"
            if (val == 131) adval = "+356"
            if (val == 140) adval = "+377"
            if (val == 149) adval = "+31"
            if (val == 171) adval = "+351"
            if (val == 184) adval = "+378"
            if (val == 191) adval = "+421"
            if (val == 192) adval = "+386"
            if (val == 196) adval = "+34"
            if (val == 202) adval = "+46"
            if (val == 221) adval = "+44"
            if (val == 222) adval = "+1"
            if (val == 226) adval = "+39"

            if (destObjt.val().length > 0) {
                if (destObjt.val().indexOf('+') != -1) {
                    arrangeval = destObjt.val()

                    if (arrangeval.indexOf(' ') != -1) {
                        newval = arrangeval.substring(arrangeval.indexOf(' ') + 1)
                        if (newval.length == 0) newval = destObjt.attr("alt")
                        destObjt.val(newval)
                    } else {
                        destObjt.val(destObjt.attr("alt"))
                    }
                }

                tlan = adval.length
                gtvl = destObjt.val()
                gtvlc = gtvl.substring(0, tlan)
                if (gtvlc != adval) {

                    gtvl = gtvl.replace(/ /g, '')
                    gtvl = adval + " " + gtvl
                    destObjt.val(gtvl)
                }
            } else {
                destObjt.val(adval) + " " + destObjt.attr("alt")
            }
        } else {
            if (destObjt.val().length > 0) {
                gtvl = destObjt.val()
                gtvl = gtvl.replace(/ /g, '')
                destObjt.val(gtvl)
            }

        }

    }


}

makeSortedParagraphs = function () {
    if ($('div.ordP').size() > 1) {
        $('div.ordP').css('cursor', 'move')
        $("div.showPackets").addClass("sortPacket")
        $("div.showPackets").sortable({
            items: "div.ordP",
            update: function (event, ui) {
                objmove = ui.item;
                newPos = objmove.index() + 1;
                gtref = objmove.attr('rel')
                gtref = gtref.split('_')
                gtref1 = gtref[0]
                gtref2 = gtref[1]

                $.ajax({

                    url: "/actions/ord_paragraphs.asp?ref=" + gtref1 + "&refp=" + gtref2 + "&newpos=" + newPos + "&ssid=" + Math.floor((Math.random() * 111111) + 1),
                    context: document.body,
                    success: function (msg) {
                        loadParagraphs()
                    }
                });
            }
        });
    }
}



fbLoadHome = function () {
    
    (function (d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/" + fb_lang + "/all.js#xfbml=1";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));
}
String.prototype.replaceAll = function (str1, str2, ignore) {
    return this.replace(new RegExp(str1.replace(/([\/\,\!\\\^\$\{\}\[\]\(\)\.\*\+\?\|\<\>\-\&])/g, "\\$&"), (ignore ? "gi" : "g")), (typeof (str2) == "string") ? str2.replace(/\$/g, "$$$$") : str2);
}
sharemefbId = function (obj) {
    try { FB.XFBML.parse(document.getElementById('homeProjects')); } catch (e) { console.log(e) }
    return;
    shareUrl = obj.attr("ulink");
    shareUrl = shareUrl.replaceAll("/", "\\/")
    //shareUrl = "http:\/\/www.imdb.com\/title\/tt2015381\/";
    console.log('shareurl: ' + shareUrl);
    $(obj).click(function () {
        FB.getLoginStatus(function (response) {
            //console.log(response);
            if (response.status === 'connected') {
                FB.api(
                    "/",
                    {
                        "id": shareUrl
                    },
                    function (response) {
                        console.log(response)
                        if (response && !response.error) {
                            if (response.og_object && response.og_object.id) {
                                console.log(response.og_object.id);
                                FB.api(
                                    "/" + response.og_object.id + "/likes",
                                    //"POST",
                                    function (response) {
                                        console.log(response)
                                        if (response && !response.error) {
                                            console.log(response);
                                        }
                                    }
                                );
                            }
                        }
                        else{
                            console.log(response.error)
                        }
                    }
                );
            }
            else {
                FB.login(function (response) {
                    if (response.authResponse) {
                        //obj.trigger("click");
                        
                    } else {
                        console.log('User cancelled login or did not fully authorize.');
                    }
                }, {
                    scope: 'publish_actions',
                    return_scopes: true
                });
                //
            }
        });
    });
 
    //$(obj).fancylike({
    //    fb_like_height: 20,
    //    fb_like_width: 20,
    //    page_url: shareUrl
    //});
}
sharemefb = function () {
    $(".fancylike-fb-like").each(function () {
        shareUrl = $(this).attr("link");
        $(this).fancylike({
            fb_like_height: 20,
            fb_like_width: 20,
            page_url: shareUrl
        });
    });
    //var arr = [];
    //$(".fb").each(function () {
    //    shareUrl = $(this).attr("link");
        
        
        //console.log( $(this).html() );
        //console.log(shareUrl);
        //alert('ao');
        //$(this).sharrre({
        //    share: {
        //        facebook: true
        //    },
        //    template: '<a class="box" href="#"><div class="count"><span>{total}</span></div></a>',
        //    url: shareUrl,
        //    enableHover: false,
        //    enableTracking: true,
        //    action: 'like',
        //    click: function (api, options) {
        //        //console.log("shareUrl");
        //        api.simulateClick();
        //        api.openPopup('facebook');

        //    }
        //});

        //url = $(this).attr("slink");
        //arr[arr.length] = { "method": "GET", "relative_url": "?id=" + "http://progettiamo.ch" + url };

        ////getFBShareCount(this);
        //setTimeout(continueExecution, 1000)
    //});
    //getFBShareCountBatch(arr);
}
function continueExecution() {
    //finish doing things after the pause
}
function getFBShareCountBatch(obj) {

    $.ajax({

        url: "http://graph.facebook.com/",
        data: { "batch": obj },
        context: document.body,
        success: function (msg) {

            console.log(msg);
        },
        error: function (msg) {
            console.log(msg);
        }
    });
}
function getFBShareCount(obj) {
    shareUrl = $(obj).attr("slink");
    $.ajax({

        url: "http://graph.facebook.com/?id=" + "http://progettiamo.ch" + shareUrl,
        context: document.body,
        success: function (msg) {
            if (msg.share)
                console.log(shareUrl + ":" + msg.share.share_count);
        }
    });
}

function mailOpen() {
    $("#mailBox").css('display', 'block');
    //$("#message").val($(".pCenter")[0].html());
}

function mailClose() {
    $("#mail1").css('display', 'none');
}

likeme = function () {
    $('.facebook').each(function (i, obj) {

        $(obj).sharrre({
            share: {
                facebook: true
            },
            action:'like',
            template: '<a class="box" href=""><div class="count" href="#">{total}</div><div class="share"><span></span>Like</div></a>',
            enableHover: false,
            enableTracking: true,
            click: function (api, options) {
                api.simulateClick();
                //api.openPopup('facebook');
            }
        });
    });

}
$(function () {
    var dialog, form,
    emailRegex = /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/,
    name = $("#name"),
    email = $("#email"),
    tips = $(".validateTips");;
    function checkLength(o, n, min, max) {
        if (o.val().length > max || o.val().length < min) {
            o.addClass("ui-state-error");
            updateTips("Length of " + n + " must be between " +
              min + " and " + max + ".");
            return false;
        } else {
            return true;
        }
    }
    function checkRegexp(o, regexp, n) {
        if (!(regexp.test(o.val()))) {
            o.addClass("ui-state-error");
            updateTips(n);
            return false;
        } else {
            return true;
        }
    }
    function updateTips(t) {
        tips
          .text(t)
          .addClass("ui-state-highlight");
        setTimeout(function () {
            tips.removeClass("ui-state-highlight", 1500);
        }, 500);
    }
    sendMail = function () {
        //e.preventDefault(); // avoid to execute the actual submit of the form.
        //$("#mailForm").submit(function (e) {
        var valid = true;
       

        valid = valid && checkLength(name, "da", 3, 16);
        valid = valid && checkLength(email, "a", 6, 80);
        

        
        valid = valid && checkRegexp(email, emailRegex, "eg. mail@progettiamo.ch");
       

        if (valid) {



            var url = "/actions/mailer.asp";

            $.ajax({
                type: "POST",
                url: url,
                data: $("#ajaxForm").serialize(), // serializes the form's elements.
                success: function (msg) {
                    if (msg == 'OK') {
                        alert("Messaggio Inviato"); // show response from the php script.
                    } else {

                        alert(msg);
                    }
                }
            });

        }
        
        $("#mailForm").dialog('close');
return valid;
        //});
    }


    
    dialog = $("#mailForm");
    if (dialog.length) {
        dialog.dialog({
        modal: true,
        autoOpen: false,
        /*height: 700,*/
        width: 800,
        buttons: {
            "ANNULLA": function () {
                dialog.dialog("close");
            },
            "INVIA": sendMail
        }, close: function () {
            form[0].reset();
        }
        });
        form = dialog.find("form").on("submit", function (event) {
            event.preventDefault();
            sendMail();
        });
    }

    

    $("#mail1").click(function () {
        //console.log ('in toggle')
        $("#imgShareDescription").text($('meta[property="og:description"]').attr('content'));
        $("#imgShareTitle").text($('meta[property="og:title"]').attr('content'));
        $("#imgSharePrj").attr('src', $('meta[property="og:image"]').attr('content'));
        $("#imgShareUrlLink").attr('href', $('meta[property="og:url"]').attr('content'));
        $("#imgShareUrlLink").text($('meta[property="og:site_name"]').attr('content'));
        //$("#mailBox").toggle();
        dialog.dialog('open');
        var target = dialog;
        $('html, body').animate({
            scrollTop: target.offset().top
        }, 1000);
    })
    //$("#dialog").draggable();




});