import flixel.text.FlxText;
import flixel.FlxG;
import hxvlc.openfl.Video;
import hxvlc.flixel.FlxVideoSprite;
import flixel.math.FlxMath;


var Lyrics = new FlxVideoSprite();
var tiktokCam:FlxCamera;
var camVid:FlxCamera;

var helpBarT:FlxSprite;
var helpBarB:FlxSprite;
var helpMeButton;
var helpButtonAllowedToScale:Bool = false;
var helpButtonClickCap:Int = 75;
var helpButtonCount:Int = 0;

var subtitles:FlxText;

var helpMeMode:Bool = false;
var succeededHelping:Bool = false;

var batteryBar:FlxSprite;
var batteryColor:FlxSprite;

var scale = 2.25;

var fakeBG:FlxSprite;


var mainBG:Array<FlxSprite> = [];

var zoomTween:FlxTween;
var shaderTweens:Array<FlxTween> = [];

var bfOGPos:Array<Float> = [];

var goodImage:FlxSprite;
var badImage:FlxSprite;

function addBehindDad(thing){
    insert(members.indexOf(dad), thing);
}
function generateBG() {
    var sky = new FlxSprite();
    sky.frames = Paths.getSparrowAtlas('bgasset');
    sky.animation.addByPrefix('i','sky');
    sky.animation.play('i');
    addBehindDad(sky);
    sky.scale.set(scale,scale);
    sky.updateHitbox();
    mainBG.push(sky);

    var t = new FlxSprite();
    t.frames = Paths.getSparrowAtlas('bgasset');
    t.animation.addByPrefix('i','bg1');
    t.animation.play('i');
    addBehindDad(t);
    t.scale.set(scale,scale);
    t.updateHitbox();
    mainBG.push(t);

    var t = new FlxSprite();
    t.frames = Paths.getSparrowAtlas('bgasset');
    t.animation.addByPrefix('i','bg2');
    t.animation.play('i');
    addBehindDad(t);
    t.scale.set(scale,scale);
    t.updateHitbox();
    mainBG.push(t);

    var t = new FlxSprite();
    t.frames = Paths.getSparrowAtlas('bgasset');
    t.animation.addByPrefix('i','bg3');
    t.animation.play('i');
    addBehindDad(t);
    t.scale.set(scale,scale);
    t.updateHitbox();
    mainBG.push(t);


    var t = new FlxSprite(-1200,400);
    t.frames = Paths.getSparrowAtlas('bgasset');
    t.animation.addByPrefix('i','tree');
    t.animation.play('i');
    add(t);
    t.scale.set(scale,scale);
    t.updateHitbox();
    t.scrollFactor.set(1.2,1.2);
    t.alpha = 0.9;
    mainBG.push(t);

    var t = new FlxSprite(4000,400);
    t.frames = Paths.getSparrowAtlas('bgasset');
    t.animation.addByPrefix('i','tree');
    t.animation.play('i');
    add(t);
    t.scale.set(scale,scale);
    t.updateHitbox();
    t.scrollFactor.set(1.2,1.2);
    t.alpha = 0.9;
    mainBG.push(t);
    remove(mainBG);
}
function go(){
    fakeBG.alpha = tiktokCam.alpha = 0;
    addBehindDad(mainBG);
}
function create() {
    tiktokCam = new FlxCamera();
    tiktokCam.bgColor = 0;
    camVid = new FlxCamera();
    camVid.bgColor = 0;
    FlxG.cameras.add(tiktokCam, false);
    FlxG.cameras.add(camVid, false);

    Lyrics.cameras = [camVid];
    Lyrics.bitmap.onEndReached.add(Lyrics.destroy);
    Lyrics.scale.set(.7,.8);
    Lyrics.setPosition(-300,-200);
    add(Lyrics);
    Lyrics.play();
    Lyrics.pause();
    Lyrics.alpha = 0.000001;

    generateBG();

    fakeBG = new FlxSprite().loadGraphic(Paths.image('og'));
    fakeBG.scale.set(1.75,1.75);
    fakeBG.updateHitbox();
    fakeBG.setPosition(2000,1200);
    fakeBG.antialiasing = true;
    addBehindDad(fakeBG);
    boyfriend.setPosition(3600, 2850);

    cacheHelpMe();

}
//pauses video
function onSubstateOpen(event) {
    if (Lyrics != null  && Lyrics.alpha == 1 && paused)
        Lyrics.pause(); 
}
function onSubstateClose(event){ 
    if (Lyrics != null && Lyrics.alpha == 1 &&  paused)
        Lyrics.resume(); 
    }
function focusGained(){
    if (Lyrics != null && Lyrics.alpha == 1 && paused)
        Lyrics.resume(); 
}
function play(){
    Lyrics.play();
    Lyrics.alpha  = 1;
    helpBarB.alpha = helpBarT.alpha = 0.001;
}
function postUpdate(){
    camHUD.zoom = .8;
    iconP1.x = 900;
    iconP2.x = 200;

    boyfriend.cameraOffset.x = -200;
    boyfriend.cameraOffset.y = -200;
    boyfriend.setPosition(3800, 2800);
    dad.setPosition(2600, 2800);
}
function setupHUD() {
    for (i in cpuStrums) {
        i.x = -1000;
    }
    for (i in [healthBar,healthBarBG]) i.visible = false;

    for (i in playerStrums) {
        i.y += -100;
    }

    batteryBar = new FlxSprite().loadGraphic(Paths.image('hpbar'));
    batteryBar.screenCenter(FlxAxes.X);
    batteryBar.y = FlxG.height - batteryBar.height + 50;
    batteryBar.antialiasing = true;
    insert(members.indexOf(iconP1), batteryBar);

    batteryColor = new FlxSprite().loadGraphic(Paths.image('barwhiteohio'));
    batteryColor.screenCenter(FlxAxes.X);
    batteryColor.y = FlxG.height - batteryBar.height + 50;
    batteryColor.setPosition(batteryBar.x + 22,batteryBar.y +  47);
    batteryColor.color = getColor();
    batteryColor.antialiasing = true;
    insert(members.indexOf(iconP1), batteryColor);

    iconP2.x = batteryBar.x - iconP2.width + 55;
    iconP1.x = batteryBar.x + batteryBar.width - 25;

    iconP1.y = batteryBar.y + (batteryBar.height - iconP1.height)/2 + 25;
    iconP2.y = batteryBar.y + (batteryBar.height - iconP2.height)/2 + 30;

    batteryBar.camera = batteryColor.camera = camHUD;
}
function postCreate() {
    setupHUD();

    defaultCamZoom = .35;
}
function getColor() {
    if (health >= 2) return 0xFF21EF36;
    else if (health >= 1.5) return 0xFF92EF58;
    else if (health >= 1) return 0xFFF1DB5C;
    else if (health >= 0.5) return 0xFFCA5427;
    else return 0xFFCD3323;
}
function onNoteHit() {
    if (batteryColor != null)
        batteryColor.color = getColor();

}
function judgeHelp() {
    helpMeMode = false;
    if (helpButtonCount >= helpButtonClickCap) {
        succeededHelping = true;
    }

    if (succeededHelping) {
        //triggerEvent('Change Character','bf','nugget_hat',Conductor.songPosition);
        boyfriend.playAnim('hatapear');
        boyfriend.stunned = true;
    }
    FlxTween.tween(helpMeButton.scale, {x: 0.0, y: 0.0},0.7,{ease: FlxEase.backIn, onComplete: Void->{
        helpButtonAllowedToScale = false;
    }});

    if (succeededHelping){
        Lyrics.load(Assets.getPath(Paths.file("videos/twiddle/lyrics_good.mp4")));  
    }
    else 
        Lyrics.load(Assets.getPath(Paths.file("videos/twiddle/lyrics_bad.mp4")));  
}

function startHelping() {
    helpMeMode = true;
    FlxG.mouse.visible = true;

    boyfriend.stunned = true;
    boyfriend.playAnim('WHAT');

    for (i in playerStrums) {
        FlxTween.tween(i, {alpha: 0},1);
    }
    FlxTween.tween(helpBarT, {alpha: 1},2,{startDelay: 1});
    FlxTween.tween(helpBarB, {alpha: 1},2,{startDelay: 1});
    FlxTween.tween(helpMeButton.scale, {x: 0.35, y: 0.35},0.7,{startDelay: 1, ease: FlxEase.backOut, onComplete: function(twn:FlxTween)
    {
        helpButtonAllowedToScale = true;
    }});
}
function postUpdate(elapsed){
    if (helpMeMode && FlxG.mouse.overlaps(helpMeButton,camHUD) && FlxG.mouse.justPressed) {
        helpButtonCount++;
        helpMeButton.scale.set(0.375,0.375);
        FlxG.camera.shake(0.0025);
    } 
    if (helpButtonAllowedToScale) {
        var s = FlxMath.lerp(helpMeButton.scale.x, 0.35,1 - Math.exp(-elapsed * 6));
        helpMeButton.scale.set(s,s);
    }
}
function cacheHelpMe() {
    helpBarT = new FlxSprite().makeGraphic(1,1,FlxColor.BLACK);
    helpBarT.scale.set(FlxG.width/3,FlxG.height);
    helpBarT.updateHitbox();
    addBehindDad(helpBarT);
    helpBarT.cameras = [tiktokCam];

    
    helpBarB = new FlxSprite(FlxG.width - (FlxG.width/3)).makeGraphic(1,1,FlxColor.BLACK);
    helpBarB.scale.set((FlxG.width/3),FlxG.height);
    helpBarB.updateHitbox();
    addBehindDad(helpBarB);
    helpBarB.cameras = [tiktokCam];

    helpMeButton = new FlxSprite(0,50).loadGraphic(Paths.image('here2'));
    helpMeButton.scale.set(0.35,0.35);
    helpMeButton.updateHitbox();
    helpMeButton.screenCenter(FlxAxes.X);
    add(helpMeButton);
    helpMeButton.cameras = [camHUD];
    helpMeButton.antialiasing = true;
    helpMeButton.scale.set();
}
function onSongStart() {
    var time = 1.5;
    FlxG.camera.fade(FlxColor.BLACK,time,true);
    FlxTween.tween(camHUD, {alpha: 1},time -0.25, {ease: FlxEase.sineOut,startDelay: 0.25});
    FlxTween.tween(camFollow, {x: camFollow.x - 700, y: camFollow.y - 100},time, {ease: FlxEase.circIn});
}
