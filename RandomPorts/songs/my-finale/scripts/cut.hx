import hxvlc.openfl.Video;
import hxvlc.flixel.FlxVideoSprite;
var Glitchyhaha = new FlxVideoSprite();
var camOther = new FlxCamera();

function create(){
    FlxG.cameras.add(camOther, false);
	camOther.bgColor = 0;
    
    Glitchyhaha.load(Assets.getPath(Paths.file("videos/cutMF.mp4")));  
    Glitchyhaha.cameras = [camOther];
    Glitchyhaha.bitmap.onEndReached.add(Glitchyhaha.destroy);
    add(Glitchyhaha);
    Glitchyhaha.play();
    Glitchyhaha.pause();
    Glitchyhaha.alpha = 0.000001;
}
//pauses video
function onSubstateOpen(event) {
    if (Glitchyhaha != null  && Glitchyhaha.alpha == 1 && paused)
        Glitchyhaha.pause(); 
}
function onSubstateClose(event){ 
    if (Glitchyhaha != null && Glitchyhaha.alpha == 1 &&  paused)
        Glitchyhaha.resume(); 
    }
function focusGained(){
    if (Glitchyhaha != null && Glitchyhaha.alpha == 1 && paused)
        Glitchyhaha.resume(); 
}
//for the cutscene
function cut(cut){
    if (cut == "1"){
        Glitchyhaha.play();
        Glitchyhaha.alpha = 1;
        camHUD.alpha = camHUD2.alpha = 0;
    }
    if (cut == "end"){
        camGame.alpha = 0;
        camHUD2.alpha = 1;
        Glitchyhaha.alpha = 0.001;
    }
}