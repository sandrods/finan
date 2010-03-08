module FormHelper

  def date_field_tag(name, value, options={})
    out = text_field_tag(name, value, options)
    js =<<-JS
      \n<script type="text/javascript" charset="utf-8">
      jQuery(function($){
         $("##{name}").mask("99/99/9999");
      });	
      </script>    
    JS
    out << js
  end

  def date_field(object, method, options={})
    out = text_field(object, "#{method}_to_form", options)
    js =<<-JS
      \n<script type="text/javascript" charset="utf-8">
      jQuery(function($){
         $("##{object}_#{method}_to_form").mask("99/99/9999");
      });	
      </script>    
    JS
    out << js
  end

  def date_label(object, method, text=nil, options={})
    label(object, "#{method}_to_form", text, options)  
  end

  def masked_text_field(object, method, options={})
    mask = options.delete(:mask)
    out = text_field(object, method, options)
    js =<<-JS
      \n<script type="text/javascript" charset="utf-8">
      jQuery(function($){
         $("##{object}_#{method}").mask("#{mask}");
      });	
      </script>    
    JS
    out << js
  end

  def currency_field(object, method, options={})
    out = text_field(object, "#{method}_to_form", options)
    js =<<-JS
      \n<script type="text/javascript" charset="utf-8">
      jQuery(function($){
         $("##{object}_#{method}_to_form").priceFormat();
      });	
      </script>    
    JS
    out << js
  end

end

module ActionView
  module Helpers
    class FormBuilder
      def date_field(method, options = {})
        @template.date_field(@object_name, method, options.merge(:object => @object))
      end
      def date_label(method, text=nil, options = {})
        @template.date_label(@object_name, method, text, options)
      end
      def masked_text_field(method, options = {})
        @template.masked_text_field(@object_name, method, options.merge(:object => @object))
      end
      def currency_field(method, options = {})
        @template.currency_field(@object_name, method, options.merge(:object => @object))
      end
    end
  end
end