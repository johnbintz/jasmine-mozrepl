require 'net/telnet'
require 'rainbow'

module Jasmine
  module MozRepl
    def repl_reload(options = {})
      options = {
        :host => '127.0.0.1',
        :port => 4242,
        :jasmine_matcher => 'localhost:8888',
        :echo_to_console => false
      }.merge(options)

      repl = Net::Telnet.new('Host' => options[:host], 'Port' => options[:port])
      repl.print(<<-ENDREPL)
var targetWindow = null;
for (var i = 0; i < window.length; ++i) {
  if (window[i].location.href.match(/#{options[:jasmine_matcher]}/)) {
    targetWindow = window[i];
    break;
  }
}

var result = null;
var descriptionNode = null;

function hasFinishedAt() {
  var as = targetWindow.document.getElementsByTagName('span');
  for (var i = 0; i < as.length; ++i) {

    if (as[i].innerHTML.match(/Finished at/)) {
      return true;
    }
  }
  return false;
}

function getDescription() {
  var descriptionNode = null;

  var as = targetWindow.document.getElementsByTagName('a');
  for (var i = 0; i < as.length; ++i) {
    if (as[i].className.match(/description/)) {
      descriptionNode = as[i].innerHTML;
      break;
    }
  }
  repl.print(descriptionNode);
}

function domReady() {
  var count = 10;

  var countdown;
  countdown = function() {
    if (hasFinishedAt()) {
      getDescription();
    } else {
      if (count > 0) {
        repl.print(count);
        setTimeout(countdown, 1000);
        count--;
      }
    }
  };

  countdown();
}

if (targetWindow) {
  targetWindow.location = targetWindow.location;
  setTimeout(domReady, 1000);
}
    ENDREPL
      message = nil

      matcher = %r{\d+ specs?, (\d+) .+ in .+s}
      repl.waitfor(matcher) { |output| message = output[matcher] }
      repl.close

      puts message.foreground(($1 == "0") ? :green : :red) if options[:echo_to_console]

      message
    end
  end
end
