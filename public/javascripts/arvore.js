function Menu(id) {  
/* função que muda a classe CSS dos elementos da lista
   de forma a abrir e fechar a árvore */

    var id;
    //pegando o li pai do link
    var lipai = id.parentNode;
    //pegando o primeiro ul
    var ulfilho = id.parentNode.getElementsByTagName ("ul")[0];
    
    if(ulfilho.className.indexOf('aberto')<0 && ulfilho.className.indexOf('fechado')<0){
        //definindo um estado inicial caso nao haja
        ulfilho.className = ulfilho.className + " aberto";
    }
    if(lipai.className.indexOf('paiaberto')<0 && lipai.className.indexOf('paifechado')<0){
        //definindo um estado inicial caso nao haja
        lipai.className = lipai.className + " paiaberto";
    }
    //fazendo a troca
    if(ulfilho.className.indexOf('aberto')>-1){
      ulfilho.className = ulfilho.className.replace("aberto","fechado");
    }else{
      ulfilho.className = ulfilho.className.replace("fechado","aberto");
    }
    //mudando a imagem do li pai
    if(lipai.className.indexOf('paiaberto')>-1){
      lipai.className = lipai.className.replace("paiaberto","paifechado");
    }else{
      lipai.className = lipai.className.replace("paifechado","paiaberto");
    }
    return false;
}
function fechaTodas(quem){
/* função para fechar inicialmente todos os elementos
   da árvore se desejar */
    var lis = document.getElementById(quem).getElementsByTagName("li");
    for (var i=0; i < lis.length ; i++){
        lis[i].className = " paifechado";
    }
    var uls = document.getElementById(quem).getElementsByTagName("ul");
    for (var i=0; i < uls.length ; i++){
        uls[i].className = " fechado";
    }
}

function abreTodas(quem){
/* função para fechar inicialmente todos os elementos
   da árvore se desejar */
    var lis = document.getElementById(quem).getElementsByTagName("li");
    for (var i=0; i < lis.length ; i++){
        lis[i].className = " paiaberto";
    }
    var uls = document.getElementById(quem).getElementsByTagName("ul");
    for (var i=0; i < uls.length ; i++){
        uls[i].className = " aberto";
    }
}

function menuNodoInvisivel(li_id){
    var div = document.getElementById(li_id).getElementsByTagName("div")[0];
    div.className = "menu_nodo_invisivel";
}


function menuNodoVisivel(li_id){   
    var div = document.getElementById(li_id).getElementsByTagName("div")[0];
    div.className = "menu_nodo_visivel";
}

