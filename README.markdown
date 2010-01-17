js\_loggable
============
Server Side Logging of Client JavaScript Errors
-----------------------------------------------

Sometimes you have the need to suppress all client side javascript... but it would be nice to know if the are issues happening in production. _js\_loggable_ is designed trap any client side javascript errors and send them back to your application to log them         


TODO
======
• Make the javascript agnostic. Currently it is jQuery

Limitations
===========
Safari (WebKit) doesn't support window.onerror so this only really works in FireFox and IE


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

    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
      "http://www.w3.org/TR/html4/strict.dtd">
    <html>

    <head>
      <meta http-equiv="Content-type" content="text/html; charset=utf-8">
      <title>JS Loggable Sample</title>

    <script src="/javascripts/jquery.min.js" type="text/javascript" charset="utf-8"></script>



    <script type="text/javascript" charset="utf-8">
      window.onerror = function(msg,url,linenumber){    
        jQuery.get( '/js_loggable/new', { navigator: encodeURI(navigator.userAgent),
                                          linenumber: linenumber,  
                                          errormsg: msg,
                                          location: url }
               );
        return true;    
      }
    </script>

    </head>

    <body id="layout.html" onload="">
  
      <script type="text/javascript" charset="utf-8">
          
      function doSomething(){
        alert('this is supposed to do something' + )
      }
    </script>

    I am main view. <a href="#" onclick="doSomethings()">click me</a>
    </body>
    </html>

What is created in the logs.
    {"navigator"=>"Mozilla/5.0%20(Macintosh;%20U;%20Intel%20Mac%20OS%20X%2010.5;%20en-US;%20rv:1.9.1.7)%20Gecko/20091221%20Firefox/3.5.7%20GTB6", "action"=>"new", "controller"=>"js_loggable", "errormsg"=>"syntax error"}
    {"navigator"=>"Mozilla/5.0%20(Macintosh;%20U;%20Intel%20Mac%20OS%20X%2010.5;%20en-US;%20rv:1.9.1.7)%20Gecko/20091221%20Firefox/3.5.7%20GTB6", "action"=>"new", "controller"=>"js_loggable", "errormsg"=>"syntax error"}
    {"linenumber"=>"30", "navigator"=>"Mozilla/5.0%20(Macintosh;%20U;%20Intel%20Mac%20OS%20X%2010.5;%20en-US;%20rv:1.9.1.7)%20Gecko/20091221%20Firefox/3.5.7%20GTB6", "action"=>"new", "controller"=>"js_loggable", "errormsg"=>"syntax error", "location"=>"http://js-loggable-sample.local/#"}
    {"linenumber"=>"30", "navigator"=>"Mozilla/5.0%20(Macintosh;%20U;%20Intel%20Mac%20OS%20X%2010.5;%20en-US;%20rv:1.9.1.7)%20Gecko/20091221%20Firefox/3.5.7%20GTB6", "action"=>"new", "controller"=>"js_loggable", "errormsg"=>"syntax error", "location"=>"http://js-loggable-sample.local/#"}

Copyright (c) 2009 Thomas Hanley, released under the MIT license