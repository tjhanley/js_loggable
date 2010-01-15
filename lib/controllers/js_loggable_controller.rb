class JsLoggableController < ApplicationController 
  
  self.append_view_path(File.join(File.dirname(__FILE__), '..', 'views'))
  
  
  def new
    @@js_loggable_logger ||= Logger.new("#{RAILS_ROOT}/log/#{RAILS_ENV}_js_loggable.log")
    @@js_loggable_logger.error params.inspect
    render :text => 'true', :status => '200', :layout => false
  end
  
  def show
     render :partial => "js_loggable"
  end
end