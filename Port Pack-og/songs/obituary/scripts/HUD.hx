import flixel.ui.FlxBar;
import flixel.text.FlxTextBorderStyle;
import flixel.math.FlxPoint;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
/*
* icon replacements
*/
public var icoP1:HealthIcon;
public var icoP2:HealthIcon;

/*
* healthbar replacement
*/
var healthBarOverlay:FlxSprite;
var healthBarStitch:FlxSprite; 

var scoreNum:FlxBitmapText;
var cmboNum:FlxBitmapText;
var accNum:FlxBitmapText;
var cmboBreaks:FlxSprite;
var score:FlxSprite;
var acc:FlxSprite;
final spacing:Float = (7*2);
final numSpacing = new FlxPoint(7,11);
var isFlashing:Bool = false;
/*
* really useful if youre going to tween the time!!
*/
public var barSongLength:Float = inst.length;

function create(){
    timeTxt = new FlxText(0, 19, 400, "X:XX", 22);
    timeTxt.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    timeTxt.antialiasing = true;
    timeTxt.scrollFactor.set();
    timeTxt.alpha = 0;
    timeTxt.borderColor = 0xFF000000;
    timeTxt.borderSize = 2;
    timeTxt.screenCenter(FlxAxes.X);

    timeBarBG = new FlxSprite();
    timeBarBG.x = timeTxt.x;
    timeBarBG.y = timeTxt.y + (timeTxt.height / 4);
    timeBarBG.alpha = 0;
    timeBarBG.scrollFactor.set();
    timeBarBG.color = FlxColor.BLACK;
    timeBarBG.loadGraphic(Paths.image("RT stuff/timeBar"));

    timeBar = new FlxBar(timeBarBG.x + 4, timeBarBG.y + 4, FlxBar.FILL_LEFT_TO_RIGHT, Std.int(timeBarBG.width - 8), Std.int(timeBarBG.height - 8), Conductor, 'songPosition', 0, 1);
    timeBar.scrollFactor.set();
    timeBar.createFilledBar(FlxColor.BLACK, FlxColor.WHITE);
    timeBar.numDivisions = 400;
    timeBar.alpha = 0;
    timeBar.value = Conductor.songPosition / Conductor.songDuration;
    timeBar.unbounded = true;

    timeBarBG.x = timeBar.x - 4;
    timeBarBG.y = timeBar.y - 4;

    timeBar.cameras = [camHUD];
    timeBarBG.cameras = [camHUD];
    timeTxt.cameras = [camHUD];

    for (i in [timeBarBG, timeBar, timeTxt]){
        add(i);
    }
}

function postCreate() {

    healthBarOverlay = new FlxSprite(null, 610).loadGraphic(Paths.image('RT stuff/hpBar'));
    healthBarOverlay.screenCenter(FlxAxes.X);
    healthBarOverlay.y += 10;
    healthBarOverlay.flipY = Options.downscroll;
    healthBarOverlay.cameras = [camHUD];
    insert(members.indexOf(healthBar) + 1, healthBarOverlay);

    remove(healthBarBG);

    healthBar.createFilledBar(FlxColor.fromRGB(71, 63, 75), FlxColor.fromRGB(255, 242, 0));
    healthBar.updateFilledBar();
    healthBar.updateBar();
    healthBar.scale.set(1, 3.2);
    healthBar.y -= 2;

    healthBarStitch = new FlxSprite().loadGraphic(Paths.image('RT stuff/stitchMiddle'));
    healthBarStitch.y = healthBar.y + 15;
    insert(members.indexOf(healthBar) + 1, healthBarOverlay);



    icoP1 = new HealthIcon(boyfriend != null ? boyfriend.getIcon() : "face", true);
    icoP2 = new HealthIcon(dad != null ? dad.getIcon() : "face", false);
    for(ico in [icoP1, icoP2]) {
        ico.y = healthBar.y - (ico.height / 2);
        ico.cameras = [camHUD];
    }
    insert(members.indexOf(healthBarOverlay) + 1, icoP1);
    insert(members.indexOf(healthBarOverlay) + 2, icoP2);

    for (i in [iconP1, iconP2]) remove(i); // fuck you og icons
}

function update(elapsed:Float){
    if (inst != null && timeBar != null && timeBar.max != barSongLength) timeBar.setRange(0, Math.max(1, barSongLength));

    if (inst != null && timeTxt != null) {
        var timeRemaining = Std.int((barSongLength - Conductor.songPosition) / 1000);
        var seconds = CoolUtil.addZeros(Std.string(timeRemaining % 60), 2);
        var minutes = Std.int(timeRemaining / 60);
        timeTxt.text = minutes + ":" + seconds;
    }

    for (ico in [icoP1, icoP2]){
        var mult:Float = FlxMath.lerp(1, ico.scale.x, FlxMath.bound(1 - (elapsed * 27), 0, 1));
        ico.scale.set(mult, mult);
    }

    icoP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) + (150 * icoP1.scale.x - 150) / 2 - 26;
    icoP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - (150 * icoP2.scale.x) / 2 - 26 * 2;

    icoP1.health = healthBar.percent / 100;
    icoP2.health = 1 - (healthBar.percent / 100);

    healthBarStitch.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - 7;
}

function onSongStart()
    for (i in [timeBar, timeBarBG, timeTxt]) FlxTween.tween(i, {alpha: 1}, 0.5, {ease: FlxEase.circOut});

function beatHit(){
    for (ico in [icoP1, icoP2]){
        ico.scale.set(1.2, 1.2);
    }
}
function events(eventName){
if (eventName == '2') {
healthBarOverlay.loadGraphic(Paths.image('RT stuff/hpBar-exe'));
healthBar.createFilledBar(FlxColor.fromRGB(71, 63, 75), FlxColor.fromRGB(237, 28, 36));
healthBar.updateFilledBar();
healthBar.updateBar();
healthBarStitch.loadGraphic(Paths.image('RT stuff/stitchMiddleEXE'));
healthBarStitch.y = healthBar.y + 15;
 }
}