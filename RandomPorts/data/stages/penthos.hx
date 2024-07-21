import openfl.display.BlendMode;
import hxvlc.openfl.Video;
import hxvlc.flixel.FlxVideoSprite;
import flixel.FlxG;

var peak = new FlxVideoSprite(-300,-180);
var thickness = 80;
var b_up;
var b_down;
var video;
var isDad;

var zoomTween:FlxTween;
var penShader = new CustomShader("tvStatic");
var random = FlxG.random.float(0.0015,0.0035);
var heStares;
var goodIntro;
var badIntro;
var penthosDance;
var cameraSpeed = FlxG.camera.followLerp;
var camOther = new FlxCamera();

var directory = 'bg/penthos/';

var newWidth = FlxG.width * 1.25;
var newHeight = FlxG.height * 1.25;
var offsetX = (FlxG.width-newWidth)/2;
var offsetY = (FlxG.height-newHeight)/2;

var allowedRotation:Bool = false;
var desiredAngle:Float = 0;

function setRotation(v) {
    allowedRotation = v; 
    if (!v) {
        desiredAngle = 0;
        FlxTween.tween(FlxG.camera, {angle: 0},0.25,{ease: FlxEase.backOut});
    }
}
function pImage(path:String) {
    return Paths.image(directory + path);
}
function pFrames(path:String) {
    return Paths.getSparrowAtlas(directory + path);
}
function addBehindDad(thing){
    insert(members.indexOf(dad), thing);
}
function onCameraMove() {
    var isDad = (curCameraTarget == 0);
    if (allowedRotation) desiredAngle = (isDad ? -2 : 2);
    heStares.animation.play(isDad ? 'L' : 'R');
}

function create() {
    boyfriend.cameraOffset.y = 200;
    dad.cameraOffset.y = -100;
    dad.cameraOffset.x = 100;
    camGame.alpha = camHUD.alpha = 0;

    goodIntro = new FlxSprite().loadGraphic(pImage('bop'));
    add(goodIntro);
    goodIntro.cameras = [camOther];
    goodIntro.scale.set(0.5,0.5);
    goodIntro.alpha = 0;

    badIntro = new FlxSprite().loadGraphic(pImage('evil'));
    add(badIntro);
    badIntro.cameras = [camOther];
    badIntro.scale.set(0.5,0.5);
    badIntro.alpha = 0;

    camOther.bgColor = FlxColor.BLACK;

    boyfriend.setPosition(900, -210);
    dad.setPosition(400, 120);

    var red = new FlxSprite(-900,-1550).loadGraphic(pImage('red'));
    red.scale.set(0.7,0.7);
    red.updateHitbox();
    addBehindDad(red);

    var particles = new FlxSprite(-300,50);
    particles.frames = pFrames('fireparticles');
    particles.animation.addByPrefix('i','burn',20);
    particles.animation.play('i');
    particles.scale.set(3,3);
    particles.updateHitbox();
    particles.alpha = 0.6;
    addBehindDad(particles);
    particles.blend = BlendMode.screen;

    var particles = new FlxSprite(1000,-50);
    particles.frames = pFrames('fireparticles');
    particles.animation.addByPrefix('i','burn',24);
    particles.animation.play('i');
    particles.scale.set(3.5,3.5);
    particles.updateHitbox();
    particles.alpha = 0.4;
    addBehindDad(particles);
    particles.blend = BlendMode.screen;

    var particles = new FlxSprite( -100,-350);
    particles.frames = pFrames('fireparticles');
    particles.animation.addByPrefix('i','burn',22);
    particles.animation.play('i');
    particles.scale.set(3.5,3.5);
    particles.updateHitbox();
    particles.alpha = 0;
    particles.flipX = true;
    addBehindDad(particles);
    particles.blend = BlendMode.screen;

    var staticFilter = new FlxSprite(-800,-750);
    staticFilter.frames = pFrames('statid');
    staticFilter.animation.addByPrefix('i','idle',22);
    staticFilter.animation.play('i');
    staticFilter.scale.set(3.5,3);
    staticFilter.updateHitbox();
    staticFilter.alpha = 0;
    staticFilter.flipX = true;
    addBehindDad(staticFilter);
    staticFilter.blend = BlendMode.difference;


    heStares = new FlxSprite(900,800);
    heStares.frames = pFrames('penhead');
    heStares.animation.addByPrefix('L','look1',24,false);
    heStares.animation.addByPrefix('R','look2',24,false);
    heStares.animation.play('L');
    addBehindDad(heStares);

    var stage = new FlxSprite( -600,-50).loadGraphic(pImage('stage'));
    stage.scale.set(0.7,0.7);
    stage.updateHitbox();
    addBehindDad(stage);

    var chari = new FlxSprite(-50,-50).loadGraphic(pImage('chair'));
    chari.scale.set(0.7,0.7);
    chari.updateHitbox();
    addBehindDad(chari);
    FlxTween.tween(chari, {y: -75, angle: 3}, 1.67,{ease: FlxEase.sineInOut,type: 4});

    var table = new FlxSprite(1500,-50).loadGraphic(pImage('table'));
    table.scale.set(0.7,0.7);
    table.updateHitbox();
    addBehindDad(table);
    FlxTween.tween(table, {y: -75, angle: -2}, 2.5,{startDelay: 1.2, ease: FlxEase.sineInOut,type: 4});

    
    var sans = new FlxSprite(2000,250).loadGraphic(pImage('mask'));
    sans.scale.set(0.7,0.7);
    sans.updateHitbox();
    addBehindDad(sans);
    FlxTween.tween(sans, {y: 300, angle: -2}, 4,{ease: FlxEase.sineInOut,type: 4});

    var particles = new FlxSprite(800,550);
    particles.frames = pFrames('fireparticles');
    particles.animation.addByPrefix('i','burn',20);
    particles.animation.play('i');
    particles.scale.set(4,4);
    particles.updateHitbox();
    particles.alpha = 0.4;
    add(particles);
    particles.blend = BlendMode.screen;


    var particles = new FlxSprite(-400,650);
    particles.frames = pFrames('fireparticles');
    particles.animation.addByPrefix('i','burn',20);
    particles.animation.play('i');
    particles.scale.set(4,4);
    particles.updateHitbox();
    particles.alpha = 0.7;
    add(particles);
    particles.blend = BlendMode.screen;

    var particles = new FlxSprite( -900,530);
    particles.frames = pFrames('fireparticles');
    particles.animation.addByPrefix('i','burn',21);
    particles.animation.play('i');
    particles.scale.set(4,4);
    particles.updateHitbox();
    particles.alpha = 0.7;
    add(particles);
    particles.blend = BlendMode.screen;

    var staticFilter = new FlxSprite(-800,-750);
    staticFilter.frames = pFrames('statid');
    staticFilter.animation.addByPrefix('i','idle',22);
    staticFilter.animation.play('i');
    staticFilter.scale.set(3.5,3);
    staticFilter.updateHitbox();
    staticFilter.alpha = 0.04;
    staticFilter.flipX = true;
    add(staticFilter);
    staticFilter.blend = BlendMode.difference;


    b_up = new FlxSprite().makeGraphic(FlxG.width,thickness,FlxColor.BLACK);
    b_up.cameras = [camHUD];
    addBehindDad(b_up);

    b_down = new FlxSprite(0,FlxG.height -thickness).makeGraphic(FlxG.width,thickness,FlxColor.BLACK);
    b_down.cameras = [camHUD];
    addBehindDad(b_down);

    //shader
    penShader.offset = 0.0025;
    penShader.strengthMulti = .5;
    penShader.contrast = 1;
    penShader.darkness = 0;
    camGame.addShader(penShader);
}

function events(event){
    switch (event) {
        case 'chat':
            penthosDance.alpha = penthosDance.alpha == 0 ? 1 : 0;
            dad.alpha = dad.alpha == 0 ? 1 : 0;
            inst.volume = inst.volume == 10 ? 1 : 10;
        case 'badFade':
            FlxTween.tween(goodIntro, {alpha: 0},1.5);
            FlxTween.tween(badIntro, {alpha: 1},1.5);
        case 'introfade':
            setZoom(.43);
            var x = dad.getMidpoint().x + 150 + (dad.cameraOffset.x + dad.cameraOffset.x);
            var y = dad.getMidpoint().y - 100 + (dad.cameraOffset.y +dad.cameraOffset.y);
            x += -200;
            camOther.alpha = 0;
            camGame.alpha= camHUD.alpha = 1;
            //camFollow.setPosition(x,y - 200);
            FlxG.camera.snapToTarget();
            FlxTween.tween(camFollow, {y: y},5.14, {ease: FlxEase.cubeInOut});
            remove(badIntro);
            remove(goodIntro);
        case 'introApp':
            camOther.alpha = 0;
            camHUD.alpha = camGame.alpha = 1;
            camHUD.zoom = 2;
            setZoom(.43);
            setRotation(true);
            goodIntro.alpha = badIntro.alpha = 0;
            remove(badIntro);
            remove(goodIntro);
        case 'headPea':
            FlxTween.tween(heStares, {y:- 300},1.7, {ease: FlxEase.backOut,onComplete:Void->{
                FlxTween.tween(heStares, {y: -275}, 2,{ease: FlxEase.sineInOut,type: 4});
            }});
        case 'vid':
            peak.play();
            peak.alpha = camOther.alpha = 1;
        case 'end':
            FlxG.camera.fade(FlxColor.BLACK, 2,false);

    }

}
function onSubstateOpen(event) {
    if (peak != null  && peak.alpha == 1 && paused)
        peak.pause(); 
}
function onSubstateClose(event){ 
    if (peak != null && peak.alpha == 1 &&  paused)
        peak.resume(); 
    }
function focusGained(){
    if (peak != null && peak.alpha == 1 && paused)
        peak.resume(); 
}
function onNoteCreation(event) {
    event.noteSprite = 'game/UI/skibidi';
}
function onCountdown(event:CountdownEvent) event.cancelled = true;

function onStrumCreation(event) {
    event.sprite = 'game/Ui/skibidi';
}
function postCreate(){
    cameraSpeed = .009;

    FlxG.cameras.add(camOther, false);
	camOther.bgColor = 0;

    defaultcamZoom = camera.zoom = camGame.zoom = .43;

    penthosDance = new FlxSprite();
    penthosDance.frames = pFrames('IShowIndie');
    penthosDance.animation.addByPrefix('i','bounce',54);
    penthosDance.animation.play('i');
    penthosDance.scale.set(2.8,2.8);
    penthosDance.updateHitbox();
    addBehindDad(penthosDance);
    penthosDance.setPosition(dad.x - 300,dad.y - 700);
    penthosDance.alpha = 0;

    //video yay
    peak.load(Assets.getPath(Paths.file("videos/aethospen.mp4")));  
    peak.cameras = [camOther];
    peak.bitmap.onEndReached.add(peak.destroy);
    peak.scale.set(.7,.7);
    add(peak);
    peak.updateHitbox();
    peak.play();
    peak.pause();
    peak.alpha = 0.000001;
}
function onSongStart() {
    FlxTween.tween(goodIntro, {alpha: 1},2, {startDelay: 1});
}
function onBeatHit() {
    if (penthosDance.alpha == 1) penthosDance.animation.play('i',true);
}
var timer = 0;
function postUpdate(elapsed){
    timer+=elapsed;
    penShader.iTime = timer;
    penShader.offset = random;
    if (allowedRotation) {
        if (curCameraTarget > 0)
            FlxG.camera.angle = FlxMath.lerp(FlxG.camera.angle , desiredAngle, 1 - Math.exp(-elapsed * 2.4 * cameraSpeed * Conductor.bpm));
    }
}
function setZoom(zoom) {
    defaultCamZoom = zoom;
}