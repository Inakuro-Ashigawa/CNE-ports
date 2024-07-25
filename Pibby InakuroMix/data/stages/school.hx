var pixel = new CustomShader("pixelated");

function create(){ 
    pixel.size = 10;

    boyfriend.cameraOffset.x = -300;
    boyfriend.cameraOffset.y = -100;
    secondtopgoop.shader = topgoop.shader = sinkgoop.shader = pixel;
}

function change(){
    secondtopgoop.alpha = topgoop.alpha = sinkgoop.alpha = penny.alpha = 1;
}
function pos(){
    dad.x = 250;
    dad.y = 350;
    dad.cameraOffset.x = 70;
    dad.cameraOffset.y = -70;
}
function beatHit(){
    // funni glitch shader lmao
    pixel.size = FlxG.random.int(5, 15);

    penny.playAnim("idle"); 
}
function onEvent(e) {
    if (e.event.name == "AppleFilter-Alt" || e.event.name == "AppleFilter"){
        if (e.event.params[0] == true || e.event.params[0] == null){

            pop3.alpha = pop.alpha = 0;

        } else if (e.event.params[0] == false){
            pop3.alpha = pop.alpha = 1;
        }
    }
}