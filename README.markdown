js\_loggable
============
Server Side Logging of Client JavaScript Errors
-----------------------------------------------

Sometimes you have the need to suppress all client side javascript... but it would be nice to know if the are issues happening in production. _js\_loggable_ is designed trap any client side javascript errors and send them back to your application to log them         

Status
======
This is _not_ a functional plugin yet. I have the a ways to go before this is even Alpha. This will for sure break stuff if you install it.

TODO
======
• Make the javascript agnostic. Currently it is jQuery
• Have the partial with the js required included automatically in any template that gets rendered by an action
• Namespace the javascript functions


Example
=======
Controller you want to log javascript for

  class Blog < ApplicationController
    include JsLoggable
    layout "layout"
  
    log_javascript :index
  
    def index
    end
  
    def show
    end
  
  end

View that is generated

  &lt;script type="text/javascript" charset="utf-8"&gt;
      function jsLoggableLogError(e) {
        try {
          $.post( '/js_loggable/new', { navigator: encodeURI(navigator.userAgent),
                                            timestamp: encodeURI(Date()),  
                                            errormsg: encodeURI(e),
                                            location: window.location }
                 ); 
          return true;
        } catch(e) {
          // don't error 
          return true; 
        }
      }
    window.onerror = jsLoggableLogError;
    alert(james); //this will error
  &lt;/script&gt;

  hello world



Copyright (c) 2009 Thomas Hanley, released under the MIT license