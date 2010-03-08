<<EOF.split("\n").each { |file| require File.join( File.dirname(__FILE__), "lib",file) }
acts_as_br
form_helper
EOF

ActionView::Helpers::FormHelper.send(:include, FormHelper)
ActionView::Base.send(:include, FormHelper)

ActiveRecord::Base.send(:include, ActsAsBr)