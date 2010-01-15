module JsLoggable #:nodoc:
  module Routing #:nodoc:
    module MapperExtensions
      def js_log
        @set.add_route("/js_log", {:controller => "js_loggable", :action => "show"})
      end
    end
  end
end