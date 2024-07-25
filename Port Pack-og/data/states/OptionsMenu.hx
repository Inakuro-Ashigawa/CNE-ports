import legacy.StupidFuckingCursorDumb;
import funkin.backend.system.framerate.Framerate;

var cursor:StupidFuckingCursorDumb;

function postCreate(){
    FlxTween.tween(Framerate.offset, {y: pathBG.height + 5}, .75, {ease: FlxEase.elasticOut});
    
    cursor = new StupidFuckingCursorDumb(0.4, 0.4);
    add(cursor);
}