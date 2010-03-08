// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function restripe(table_id){
    var table = $(table_id);
    if (table) {
      var trs = table.getElementsByTagName('tr');
      for (var i = 0; i < trs.length; i++) {
        // remove existing classnames first
        Element.removeClassName(trs[i], 'even');
        Element.removeClassName(trs[i], 'odd');
        clsname = (i % 2 == 0) ? 'odd' : 'even'
        Element.addClassName(trs[i], clsname); 
      }      
    }
}

function restripe_div(id) {
	
	$(id).select("div.tr").each( function(tr, i) {
		tr.removeClassName('even')
		if (i % 2 != 0) {
			tr.addClassName('even')			
		}
	})

}