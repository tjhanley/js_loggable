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
    # Returns true if the current action is supposed to run as SSL
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
