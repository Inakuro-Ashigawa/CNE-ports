import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import lime.utils.Assets;
import flixel.ui.FlxBar;
import openfl.display.BlendMode;

var selector:FlxText;
var curSelected:Int = 0;
var curDifficulty:Int = -1;
var lastDifficultyName:String = '';
var dogeTxt:FlxText;

var scoreBG:FlxSprite;
var scoreText:FlxText;
var diffText:FlxText;
var songText:FlxTypeText;
var artistText:FlxTypeText;
var lerpScore:Int = 0;
var lerpRating:Float = 0;
var threatLerp:Float = 0;
var intendedScore:Int = 0;
var intendedRating:Float = 0;
var threatPercent:Int;
var bg:FlxSprite;
var arrowL:FlxSprite;
var arrowR:FlxSprite;
var arrows:FlxSprite;
var image:FlxSprite;
var stagebox:FlxSprite;
var stagebox_L:FlxSprite;
var stagebox_R:FlxSprite;
var threat:FlxSprite;
var levelBarBG:FlxSprite;
var levelBar:FlxBar;
var gradient:FlxSprite;
var shaderIntensity:Float;

function create()
{

window.title = "Pibby: Apocalypse - Freeplay";
bg = new FlxSprite();
bg.frames = Paths.getSparrowAtlas('fpmenu/background');
bg.animation.addByPrefix('idle', 'background idle', 30, true);
bg.animation.play('idle');
bg.antialiasing = Options.Antialiasing;
add(bg);
bg.screenCenter();

threat = new FlxSprite().loadGraphic(Paths.image('fpmenu/threatLevel'));
threat.antialiasing = Options.Antialiasing;
add(threat);
threat.screenCenter();

image = new FlxSprite().loadGraphic(Paths.image('fpmenu/stage/Suffering Siblings'));
image.antialiasing = Options.Antialiasing;
add(image);
image.screenCenter();

stagebox = new FlxSprite().loadGraphic(Paths.image('fpmenu/stageBox'));
stagebox.antialiasing = Options.Antialiasing;

add(stagebox);
stagebox.screenCenter();

arrowL = new FlxSprite().loadGraphic(Paths.image('fpmenu/arrowL'));
arrowL.antialiasing = Options.Antialiasing;
add(arrowL);
arrowL.scale.set(4, 4);
arrowL.blend = add;
arrowL.screenCenter();

arrowR = new FlxSprite().loadGraphic(Paths.image('fpmenu/arrowR'));
arrowR.antialiasing = Options.Antialiasing;
add(arrowR);
arrowR.scale.set(4, 4);
arrowR.blend = add;
arrowR.screenCenter();

songText = new FlxText(image.x, image.y + 35, Std.int(FlxG.width * 1), "Suffering Siblings");
songText.antialiasing = Options.Antialiasing;
songText.setFormat(Paths.font("menuBUTTONS.ttf"), 64, FlxColor.WHITE, "center");
songText.blend = add;
songText.shader = pibbyFNF;
add(songText);

artistText = new FlxText(songText.x, songText.y + 80, Std.int(FlxG.width * 1), "Awe (ft. Saster)");
artistText.antialiasing = Options.Antialiasing;
artistText.setFormat(Paths.font("type.ttf"), 36, FlxColor.WHITE, "center");
artistText.blend = add;
artistText.shader = pibbyFNF;
add(artistText);

levelBarBG = new FlxSprite(threat.x + 630, threat.y + 510).loadGraphic(Paths.image('fpmenu/threatBarBG'));
levelBarBG.antialiasing = Options.Antialiasing;
add(levelBarBG);

levelBar = new FlxBar(levelBarBG.x + 4, levelBarBG.y + 4, FlxBar.LEFT_TO_RIGHT, Std.int(levelBarBG.width - 8), Std.int(levelBarBG.height - 8), threatPercent,
    'threatLerp', 95, 100);
levelBar.scrollFactor.set();
levelBar.createFilledBar(0x00000000, FlxColor.WHITE, true);
levelBar.antialiasing = Options.Antialiasing;
levelBar.setRange(0, Math.max(100, 95));
levelBar.updateBar();
add(levelBar);

gradient = new FlxSprite(0, 0, Paths.image('PA Stuff/gradient'));
gradient.screenCenter();
gradient.setGraphicSize(Std.int(gradient.width * 0.75));
gradient.alpha = 0;
gradient.antialiasing = Options.Antialiasing;
add(gradient);

FlxTween.tween(gradient, {alpha: 1}, 1, {ease: FlxEase.sineInOut, type: 4});

dogeTxt = new FlxText(0, FlxG.height - 50, 0, "♪ Now Playing: Freeplay Theme - By Doge ♪", 8);
dogeTxt.setFormat(Paths.font("mum.ttf"), 24, FlxColor.WHITE, "left");
dogeTxt.alpha = 0;
dogeTxt.antialiasing = Options.Antialiasing;
add(dogeTxt);


FlxTween.tween(dogeTxt, {alpha: 1}, 1.5, {
    ease: FlxEase.quadInOut, 
    startDelay: 2,
    onComplete: 
    function (twn:FlxTween)
        {
            FlxTween.tween(dogeTxt, {alpha: 0}, 1.5, {
                ease: FlxEase.quadInOut, startDelay: 2});
        }
});
}
var pibbyFNF = new CustomShader('dayybloomshader');  
function update(elapsed:Float)
{
  


Conductor.bpm = 100;
stagebox.y = 3 + Math.sin(Conductor.songPosition/600)*((FlxG.height * 0.015));
image.y = 3 + Math.sin(Conductor.songPosition/600)*((FlxG.height * 0.015));
arrowL.y = 290 + Math.sin(Conductor.songPosition/600)*((FlxG.height * 0.065));
arrowR.y = 290 + Math.sin(Conductor.songPosition/600)*((FlxG.height * 0.065));

FlxG.camera.zoom = FlxMath.lerp(1, FlxG.camera.zoom, FlxMath.bound(1 - (elapsed * 3.125), 0, 1));
threatLerp = FlxMath.lerp(threatLerp, threatPercent, FlxMath.bound(elapsed * 4, 0, 1));


if (controls.BACK)
{
 FlxG.switchState(new ModState("PA/Main"));
}
if (controls.ACCEPT)
    {
    loadSong();
    }
}
function loadSong() {      
PlayState.loadSong("Suffering-Siblings", "normal", false, false);
FlxG.switchState(new PlayState());
}
function stepHit() {

    if (FlxG.random.int(0, 1) < 0.01) 
        {
            shaderIntensity = FlxG.random.float(0.2, 0.3);
        }
    //pibbyFNF.glitchMultiply = shaderIntensity;
}