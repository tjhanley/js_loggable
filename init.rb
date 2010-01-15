# Include hook code here
require 'js_loggable'

controller_path = File.join(directory, 'lib', 'controllers')
$LOAD_PATH << controller_path
ActiveSupport::Dependencies.load_paths << controller_path
config.controller_paths << controller_path

require "routing"
ActionController::Routing::RouteSet::Mapper.send :include, JsLoggable::Routing::MapperExtensions