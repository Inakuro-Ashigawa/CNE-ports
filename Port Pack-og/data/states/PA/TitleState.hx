import haxe.Json;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
var titleJSON:TitleData;
var titleTextColors:Array<FlxColor> = [0xFF33FFFF, 0xFF3333CC];
var titleTextAlphas:Array<Float> = [1, .64];
var logoBl:FlxSprite;
var titleText:FlxSprite;
var titlex:Float;
var titley:Float;
var pressedEnter:Bool = FlxG.keys.justPressed.ENTER || controls.ACCEPT;

function create(){
window.title = "Pibby: Apocalypse - Title Screen";
logoBl = new FlxSprite();
logoBl.frames = Paths.getSparrowAtlas('PA Stuff/logoPeb');
logoBl.antialiasing = Options.Antialiasing;
logoBl.animation.addByPrefix('bump', 'Bumping', 24, false);
logoBl.animation.play('bump');
logoBl.updateHitbox();
logoBl.screenCenter();
add(logoBl);

titleText = new FlxSprite();
titleText.frames = Paths.getSparrowAtlas('PA Stuff/titleEnter');
titleText.animation.addByPrefix('idle', "ENTER IDLE", 24);
titleText.animation.addByPrefix('press', Options.flashing ? "ENTER PRESSED" : "ENTER FREEZE", 24);
titleText.antialiasing = Options.Antialiasing;
titleText.animation.play('idle');
titleText.screenCenter();
titleText.x += 250;
titleText.y += 200;
add(titleText);

}
function update(elapsed:Float)
{
if (controls.ACCEPT)
        {
        titleText.color = FlxColor.WHITE;
        titleText.alpha = 1;
        
        if(titleText != null) titleText.animation.play('press');

        FlxG.camera.flash(Options.flashing ? FlxColor.WHITE : 0x4CFFFFFF, 1);
        FlxG.sound.play(Paths.sound('confirmMenu'), 1);


        new FlxTimer().start(1, function(tmr:FlxTimer)
        {

            FlxG.switchState(new ModState("PA/Main"));
        });
    }
}
function beatHit()
	{
		if(logoBl != null)
			logoBl.animation.play('bump', true);
    }