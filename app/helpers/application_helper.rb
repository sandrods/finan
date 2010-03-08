# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def cool_button(text, link_opts={}, opts={})
    icon = opts.delete(:icon)||'add'
    ultimo = opts.delete(:ultimo)

    opts[:class] = 'button'

    ic = (icon == '') ? '' : "<b class='icon #{icon}'></b>" 
    ret = link_to("<span>#{ic}#{text}</span>", link_opts, opts)
    ret << "<br style='clear:both' />" if ultimo
    ret
  end

  def cool_button_remote(text, link_opts={}, opts={})
    icon = opts.delete(:icon)||'add'
    no_br = opts.delete(:no_br)

    options = {:url=>link_opts}
    confirm = opts.delete(:confirm)
    options[:confirm] = confirm if confirm
    
    if opts[:redbox]
      ret = link_to_remote_redbox("<span><b class='icon #{icon}'></b>#{text}</span>", options, {:class=>'button'})
    else
      ret = link_to_remote("<span><b class='icon #{icon}'></b>#{text}</span>", options, {:class=>'button'})
    end
    
    ret << "<br style='clear:both' />" unless no_br
    ret
  end

  def restripe(table_id)
    <<-EOF
        
        var table = $('#{table_id}');
        if (table) {
          var trs = table.getElementsByTagName('tr');
          for (var i = 0; i < trs.length; i++) {
            // remove existing classnames first
            Element.removeClassName(trs[i], 'even');
            Element.removeClassName(trs[i], 'odd');
            clsname = (i % 2 == 0) ? 'even' : 'odd'
            Element.addClassName(trs[i], clsname); 
          }      
        }
          
    EOF
    
  end
  
  def rebuild_sortable(table_id, url)
    <<-EOF
      Sortable.create('#{table_id}', {handle:'handle', onUpdate:function(){new Ajax.Request('#{url}', {asynchronous:true, evalScripts:true, onLoading:function(request){restripe('#{table_id}')}, parameters:Sortable.serialize("#{table_id}")})}, tag:'tr'})
    EOF
    
  end
  
  def flash_message(tipo)
    content_tag("div", flash[tipo], :class=>"#{tipo.to_s}")
  end

  def nl2br(s)
    if s
      s.gsub(/\n/, '<br>')
    else
      ''
    end
  end
  
  def test_error_message_on(object, method)
    error_message_on(object, method, :css_class=>"formError erro_#{method}")
  end

  def test_label(form, id, field_name, text, options = {})
    label = form.label(field_name, text, options)

    if label =~ /for="([^"]*)"/
      label.gsub!($1, "#{$1}_#{id}")
    end

    label
  end

  def permissao?(permissao)
    tkt = session[:ticket]
    tkt.direitos.include?(permissao)
  end

  def label_pode_editar(questionario)
    tkt = session[:ticket]
    questionario.pode_editar?(tkt) ? 'Editar' : 'Ver'
  end
  
  def link_to_pode_excluir(questionario, *args)
    tkt = session[:ticket]
    questionario.pode_editar?(tkt) ? link_to(*args) : ''
  end
  
  def errors_for(model)
    ret = ""
    model.errors.each_full do |error|
      ret << "<p>#{error}</p>"
    end
    ret = "<div class='error'>#{ret}</div>" unless ret.blank?
    ret
  end
  
end
