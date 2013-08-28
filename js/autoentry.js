var LoginTest, end, f, fncs, home_url, max, num, page, recursive, _fncs;

num = 0;

end = 0;

max = 10;

_fncs = [];

home_url = 'http://tamagotch.channel.or.jp/event/event_anniversarycontest/';

f = function() {};

page = require('webpage').create();

page.onInitialized = function() {
  page.evaluate(function() {
    document.addEventListener('DOMContentLoaded', function() {
      window.callPhantom('DOMContentLoaded');
    }, false);
  });
};

LoginTest = function(f) {
  this.f = f;
  this.init();
};

LoginTest.prototype = {
  init: function() {
    var self;

    self = this;
    page.onCallback = function(data) {
      if (data === 'DOMContentLoaded') {
        self.next();
      }
    };
  },
  next: function() {
    this.f();
  }
};

fncs = [
  function(parent) {
    console.log('--------------- Shimakousaku-chi Entry ' + num + ' ---------------');
    page.open(home_url);
  }, function(parent) {
    var fn;

    console.log('open entry');
    fn = 'arr = document.getElementById("form1"); arr.elements["select_ans"].value = "46"; arr.elements["mode"].value = "conf"; arr.elements["contest_id"].value = "1"; arr.submit();';
    page.evaluate(new Function(fn));
  }, function(parent) {
    var fn;

    console.log('entry...');
    fn = 'arr = document.getElementById("form1"); arr.elements["select_ans"].value = "46"; arr.elements["mode"].value = "send"; arr.elements["contest_id"].value = "1"; arr.submit();';
    page.evaluate(new Function(fn));
  }, function(parent) {
    console.log('entry complate!');
    console.log('done: (' + (num + 1) + '/' + max + ')');
    page.clearCookies();
    page.open(home_url);
  }, function(parent) {
    console.log('LAST');
  }
];

recursive = function(i) {
  if (i < fncs.length - 1) {
    page.onLoadFinished = function() {
      recursive(i + 1);
    };
    fncs[i]();
  } else {
    if (max <= ++num) {
      console.log('--------------- END ---------------');
      phantom.exit();
    } else {
      recursive(0);
    }
  }
};

recursive(0);
