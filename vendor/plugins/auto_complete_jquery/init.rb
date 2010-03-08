# Include hook code here
require 'auto_complete_jquery'

ActionView::Base.send(:include, AutoCompleteJqueryHelpers)
ActionView::Helpers::FormHelper.send(:include, AutoCompleteJqueryHelpers)

ActionController::Base.send(:include, AutoCompleteJqueryHelpers)
