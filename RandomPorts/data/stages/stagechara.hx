
function postCreate(){
    Flowers.color = FlxColor.BROWN;
    PARTICULAS.color = FlxColor.YELLOW;
}
function remove(){
    Light.alpha = PARTICULAS.alpha = 0.001;
}
function back(){
    Light.alpha = PARTICULAS.alpha = 1;
}