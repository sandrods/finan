class MenusController < ApplicationController
#  layout 'conf'

  def index
    @roots = Menu.find_all_by_parent_id(nil, :order=>'ordem')
  end

  def children
    @parent = Menu.find(params[:id])
    @level = params[:level].to_i
    response.headers['Content-Type'] = 'text/html;charset=utf-8'
    render(:layout => false)
  end

  def children_ie
    @parent = Menu.find(params[:id])
    @level = params[:level].to_i
    response.headers['Content-Type'] = 'text/html;charset=utf-8'
    render(:layout => false)
  end

  def consulta
     @nodo1 = Menu.find(params[:id])
  end

  def salva

    @nodo1 = Menu.find(params[:id])
   
    if @nodo1.update_attributes(params[:nodo])
      flash[:notice] = 'Menu ATUALIZADO com sucesso'
      redirect_to :action => 'index' 
    else
      render :action => 'consulta'
    end
  end

  def novo
    @nodo1 = Menu.new
    @nodo1.parent_id = params[:id_pai]
  end

  def inclui
    @nodo1 = Menu.new(params[:nodo])
    
    if @nodo1.save
      flash[:notice] = 'Menu incluido com sucesso.'
      if params[:commit] == 'Salvar'
        redirect_to :action => 'index'
      else
        redirect_to :action => 'novo', :id_pai=>@nodo1.parent_id
      end
    else
      render :action => 'novo'    
    end
  end

  def exclui
    @nodo1 = Menu.find(params[:id])
    @nodos = @nodo1.ramo.collect{|n| n.id }
        
    @ok = @nodo1.destroy
  end  

  def ordena
    @ok=true
    params[:nodos].each_with_index do |nodo, i|
      Menu.set_ordem(nodo, i.to_i + 1)
    end
  end

  def drop
    target = Menu.find(params[:drop_id].to_i)
    source = Menu.find(params[:id].gsub('page-','').to_i)
    if target.parent_id != source.parent_id
      source.update_attribute('parent_id', target.id) 
    else
      source.insert_at(target.ordem)
    end
  end

  def auto_complete_for_recurso_id
    lista = Recurso.to_autocomplete(params[:q])
    render :inline => lista.map{ |u| "#{u.descricao}|#{u.id}" }.join("\n")    
  end

end
