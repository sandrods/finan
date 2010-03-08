# AutoCompleteJquery
module AutoCompleteJqueryHelpers

  def ac_results(list, name, id = nil)
    list.map do |item|
      if id
        "#{item.send(name)}|#{item.send(id)}"
      else
        "#{item.send(name)}"
      end
    end.join("\n")
  end

  def ac_assets(include_jquery = false)
    ret = include_jquery ? javascript_include_tag("jquery") : ""
    ret << javascript_include_tag("jquery.autocomplete") + stylesheet_link_tag('jquery.autocomplete')
  end

  def ac_field_tag(name, tag_options = {})

    options = {}
    options[:name] = name
    options[:ac_for] = name
    options[:tag_options] = tag_options
    options[:hidden_f] = hidden_field_tag(name)

    ac_tag_with_id(options)

  end

  def ac_field_tag_no_id(name, tag_options = {})

    options = {}
    options[:name] = name
    options[:ac_for] = name
    options[:tag_options] = tag_options

    ac_tag(options)

  end

  def ac_field(object_name, method, tag_options = {})

    options = {}
    options[:name] = "#{object_name}_#{method}"
    options[:ac_for] = method
    options[:tag_options] = tag_options
    options[:hidden_f] = hidden_field(object_name, method)
    
    ac_tag_with_id(options)

  end

  def ac_field_no_id(object_name, method, tag_options = {})

    options = {}
    options[:name] = "#{object_name}_#{method}"
    options[:ac_for] = method
    options[:tag_options] = tag_options
    
    ac_tag(options)

  end

private

  def ac_tag_with_id(options = {})

    tag_options = options.delete(:tag_options) || {}

    url_hash = tag_options[:url] || {:action => "auto_complete_for_#{options[:ac_for]}"}
    url = url_for(url_hash)

    must_match =  tag_options.delete(:must_match) || 'true'
    auto_fill =   tag_options.delete(:auto_fill) || 'false'
    min_chars =   tag_options.delete(:min_chars) || 3

    text_f_value = tag_options.delete(:value)
    text_f_name = "#{options[:name]}_ac"
    text_f = text_field_tag(text_f_name , text_f_value, tag_options)

    hidden_f_name = options[:name]
    hidden_f = options[:hidden_f]

    js = javascript_tag <<-JS
			jQuery(function($){
				$("##{text_f_name}").autocomplete("#{url}", {
					minChars: #{min_chars},
					autoFill: #{auto_fill},
					mustMatch: #{must_match},
					matchContains: true,
					selectFirst: false
				});
				$("##{text_f_name}").result(function(event, data, formatted) {
						if (data)
							$("##{hidden_f_name}").val(data[1]);
				});
				$("##{text_f_name}").blur(function() {
						if ($("##{text_f_name}").val() == '') {	$("##{hidden_f_name}").val(''); }
						if ($("##{hidden_f_name}").val() =='') { $("##{text_f_name}").val(''); }
				});
			});      
    JS

    return js + text_f + hidden_f
  end

  def ac_tag(options = {})

    tag_options = options.delete(:tag_options) || {}

    url_hash = tag_options[:url] || {:action => "auto_complete_for_#{options[:ac_for]}"}
    url = url_for(url_hash)

    must_match =  tag_options.delete(:must_match) || 'true'
    auto_fill =   tag_options.delete(:auto_fill) || 'false'
    min_chars =   tag_options.delete(:min_chars) || 3

    text_f_value = tag_options.delete(:value)
    text_f_name = options[:name]
    text_f = text_field_tag(text_f_name , text_f_value, tag_options)

    js = javascript_tag <<-JS
			jQuery(function($){
				$("##{text_f_name}").autocomplete("#{url}", {
					minChars: #{min_chars},
					autoFill: #{auto_fill},
					mustMatch: #{must_match},
					matchContains: true,
					selectFirst: false
				});
			});      
    JS

    return js + text_f
  end

end

module ActionView
  module Helpers
    class FormBuilder
      def ac_field(method, options = {})
        @template.ac_field(@object_name, method, options.merge(:object => @object))
      end
    end
  end
end