# Dinamic-menus
module DynamicMenus

  def self.included(base)
    base.module_eval "before_filter :set_nodo"
  end

  def set_nodo

    session[:nodo_menu] = Menu.find params[:nd] if params[:nd]

  end

end