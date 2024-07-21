function beatHit(curBeat){
    if (curBeat % 2 == 0){
        b.playAnim("idle");
        pico.playAnim("idle");
        gfb.playAnim("idle");
    }
}
function postCreate(){
    dad.cameraOffset.x = 0;
    dad.cameraOffset.y = -200;
    boyfriend.cameraOffset.x = -100;
    boyfriend.cameraOffset.y = -60;
}