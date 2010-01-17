# JsLoggable
module JsLoggable
  def self.included(controller)
    controller.extend(ClassMethods)
    controller.before_filter(:make_javascript_loggable)
  end                                       
  module ClassMethods
    def log_javascript(*actions)
      write_inheritable_array(:log_javascript_actions, actions)
    end
  end
  
  protected
    # Returns true if the current action is supposed to run with JS Logging
    def js_loggable?
      (self.class.read_inheritable_attribute(:log_javascript_actions) || []).include?(action_name.to_sym)
    end
  
  private
    def make_javascript_loggable
      if js_loggable?
         $stdout.puts "javascript log me"
      end
    end
end

module ActionController
	class Base
		def process_with_js_loggable(request,response, method = :perform_action, *arguments)
		    $browser_buf ||= []
            # $browser_buf ||= [] if js_loggable?
			process_without_js_loggable(request,response, method, *arguments)   
		end
		alias_method :process_without_js_loggable, :process
		alias_method :process, :process_with_js_loggable
	end
	class CgiResponse
		def out_with_js_loggable(output = $stdout)
			if $browser_buf
			    js_loggable_content = ERB.new(File.open(File.join(File.dirname(__FILE__), 'views','js_loggable','_js_loggable.erb'), 'r').read).result
			    
				body.gsub!(/<\/head>/mi,"\n#{js_loggable_content}\n<\/head>\n")       
				$browser_buf = nil
			end
			out_without_js_loggable(output)
		end
		alias_method :out_without_js_loggable, :out
		alias_method :out, :out_with_js_loggable
	end
end
