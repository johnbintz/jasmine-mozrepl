Reload [Jasmine](https://jasmine.github.io/) test suites in Firefox using [MozRepl](https://github.com/bard/mozrepl) and this lovely gem.

Use it with **watchr**:

    require 'jasmine-mozrepl'

    extend Jasmine::MozRepl

    watch('public/javascript/.*\.js') { do_reload }
    watch('spec/javascripts/.*_spec\.js') { do_reload }

    def do_reload
      system %{growlnotify -m "#{repl_reload(:echo_to_console => true)}" -t "Jasmine suite"}
    end

    do_reload

**repl_reload** options:

* **:host** is the host to connect to *(default: 127.0.0.1)*
* **:port** is the post to connect to *(default: 4242)*
* **:jasmine_matcher** is the address in the address bar to search for *(default: "localhost:8888")*
* **:echo_to_console** writes the success/failure message to the console in red/green *(default: false)*

**repl_reload** returns the success/failure count message from Jasmine so you can use it as you wish.
