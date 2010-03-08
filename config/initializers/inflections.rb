# Be sure to restart your server when you modify this file.

ActiveSupport::Inflector.inflections do |inflect|
  
   inflect.plural /^(.*)ao$/i, '\1oes'
   inflect.singular /^(.*)oes$/i, '\1ao'

   inflect.plural(/^(.*)m$/i, '\1ns')
   inflect.singular(/^(.*)ns$/i, '\1m')

   inflect.plural(/^(.*)r$/i, '\1res')
   inflect.singular(/^(.*)res$/i, '\1r')

   inflect.plural(/^(.*)il$/i, '\1is')
   inflect.singular(/^(.*)is$/i, '\1il')

end
