# Include hook code here
ActiveSupport::Dependencies.load_once_paths.delete(
  File.expand_path(File.dirname(__FILE__))+'/app/controllers')

ActiveSupport::Dependencies.load_once_paths.delete(
  File.expand_path(File.dirname(__FILE__))+'/app/models')

  ActionView::Base.send(:include, MenusHelper)

require 'dynamic_menus'

