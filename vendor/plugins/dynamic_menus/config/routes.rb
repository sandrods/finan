ActionController::Routing::Routes.draw do |map|

  map.with_options(:controller => 'menus') do |page|
    page.page_children     'menus/children/:id/:level', :action => 'children',   :level => '1'  
    page.page_children     'menus/children_ie/:id/:level', :action => 'children_ie',   :level => '1'  
  end

end