class RegistrosController < InheritedResources::Base
  
  def index
    @creditos = Registro.creditos.all
    @debitos = Registro.debitos.all
  end

end
