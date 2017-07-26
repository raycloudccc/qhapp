function showTip(context,width,height){
    alert(111)
    var div1=$('<div class="tipBack"></div>');
    var div2=$('<div class="tipContent"></div>');
    div2.html(context);
    div2.width(width);
    div2.height(height);
    div2.css('margin-left',-(width/2));
    div2.css('margin-left',-(height/2));
    $('.myTip').append(div1).append(div2);
    $('.myTip').show();
}