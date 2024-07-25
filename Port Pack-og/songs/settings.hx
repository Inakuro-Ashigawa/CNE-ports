var option = FlxG.save.data;
import legacy.StupidFuckingCursorDumb;


var cursor:StupidFuckingCursorDumb;
function postCreate(){
    //Botplay
    if (FlxG.save.data.botplay) player.cpu = true;

    if (option.customCursor) option.customCursor = true;
    //if (option.pibbyCursor) option.pibbyCursor = true;

    cursor = new StupidFuckingCursorDumb(0.4, 0.4);
    add(cursor);

}