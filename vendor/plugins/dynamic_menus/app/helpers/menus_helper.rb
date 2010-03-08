module MenusHelper
  
  def dynamic_menus
    nodo = session[:nodo_menu]
    
    conteudo = ''
    conteudo = yield if block_given?

    html = <<-HTML
      <div id="menu">
    		#{conteudo}		
    		<ul id="nav">#{abas(nodo)}</ul>
      </div>
      <div id='sub-menu'>#{sub_menu(nodo)}</div>
    HTML

    html
  end

  def abas(menu)
    if menu
      root = menu.root
    else
      root = Menu.scoped(:order=>:id).first
      menu = root
    end
    
    return "" unless root
    
    ret = ''
    root.children.each do |a|
      # Mostra a aba se ela é visível, e se tem algum filho visível
      if a.visivel?(session[:ticket]) && (a.children.empty? ? true : a.children.collect{|c| c.visivel?(session[:ticket])}.include?(true))
        active = (a==menu || menu.ancestors.include?(a)) ? "class='active'" : ''
        ret << "<li #{active}> #{link_to(a.titulo, :controller=>a.controller||'/', :action=>a.action||'index', :nd=>a)}</li>\n"
      end
    end
    ret
  end

  def sub_menu(menu, active=nil)     
    sm = sub_menu(menu.parent, menu) if menu && menu.parent && menu.parent.parent
    (sm||'') + escreve(menu, active)
  end

  def escreve(menu, active)
    return "<h3></h3>" unless menu && params[:nc]!='1' #só para a primeira chamada
    if !menu.children || menu.children.empty? || menu.parent_id==nil
      if menu.aba? || menu.parent_id==nil
        return "<h3></h3>"
      else
        return ""
      end
    end
    active = menu.children.first unless active

    visiveis = menu.children.select { |n| n.visivel?(session[:ticket], session[:perfis_pasta]) }
    last = visiveis.last

    linha = visiveis.map do |n|

      if n.id == (active && active.id)
        if n.id == (last && last.id)
          opt = {:class => 'active last'}
        else
          opt = {:class => 'active'}
        end
      else
        opt = {:class => 'last'} if n.id == (last && last.id)
      end

      link_to n.titulo, {:controller=>n.controller||'/main', :action=>n.action||'index', :nd=>n}, opt
    end

    if menu.aba?
      "<h3>#{linha.compact.join}</h3>"
    else
      "<h2>#{linha.compact.join}</h2>"    
    end
  end


  def menu_render_node(page, locals = {})
    locals.reverse_merge!(:level => 0, :simple => false).merge!(:page => page)
    render :partial => 'node', :locals =>  locals
  end

  def menu_expanded_rows
    case
    when row_string = (cookies['expanded_rows'] || []).first
      row_string.split('*').map { |x| Integer(x) rescue nil }.compact
    when @root
      [@root.id]
    else
      []
    end     
  end
  
  def meta_errors?
    !!(@page.errors[:slug] or @page.errors[:breadcrumb])
  end

  def has_permission(nodo)
    true
    #nodo.permissoes.empty? || session[:ticket].permissao?('ADMIN') || nodo.permissoes.map{|i| i.id}.include?(session[:ticket].setor_id)
  end

end