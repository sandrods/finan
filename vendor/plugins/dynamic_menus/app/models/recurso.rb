class Recurso < ActiveRecord::Base
  set_table_name "acesso_web.recursos"

  belongs_to :sistema

  def self.to_select
   sistema = Sistema.find(:first, :conditions=>['sigla = ?', MAPA_NAME])
   if sistema 
     Recurso.find_all_by_sistema_id(sistema.id, :order=>'descricao').map {|s| [s.descricao, s.id]}
   else
     []
   end   
  end

  def before_save
    # Impedir qualquer gravação
    false
  end

end
