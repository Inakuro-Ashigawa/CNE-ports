import hxvlc.openfl.Video;
import hxvlc.flixel.FlxVideoSprite;
var bopperss;
var camVid:FlxCamera;
var blackBarThingie2:FlxSprite;
var vid = new FlxVideoSprite();
var shader = new CustomShader("ntsc");
function addBehindDad(thing){
    insert(members.indexOf(dad), thing);
}
function create(){
    camVid = new FlxCamera();
	camVid.bgColor = 0;
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(camVid, false);
	FlxG.cameras.add(camHUD, false);

    blackBarThingie2 = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    blackBarThingie2.setGraphicSize(Std.int(blackBarThingie2.width * 10));
    blackBarThingie2.alpha = 0;
    blackBarThingie2.cameras = [camHUD];
    add(blackBarThingie2);

    vid.load(Assets.getPath(Paths.file("videos/death.mp4")));  
    vid.camera = camVid;
    add(vid);
    vid.play();
    vid.pause();
    vid.alpha = 0.000001;

    boyfriend.forceIsOnScreen = true;
    camGame.bgColor = FlxColor.WHITE;
    camGame.addShader(shader);
    camVid.addShader(shader);

    bg = new FlxSprite(-200, -300).loadGraphic(Paths.image("muffin/bg"));
    bg.scale.set(1.2,1.2);
    bg.scrollFactor.set(0.2, 0.6);
    bg.updateHitbox();
    addBehindDad(bg);

    head = new FlxSprite(600, -100);
    head.frames = Paths.getSparrowAtlas('muffin/head');
    head.animation.addByPrefix('bop', "head", 18, true);
    head.animation.play('bop');
    head.scale.set(.6,.6);
    head.updateHitbox();
    head.scrollFactor.set(0.7, 1);
    FlxTween.tween(head, {y: -30}, 2.5,{startDelay: 1.2, ease: FlxEase.sineInOut,type: 4});
    addBehindDad(head);

    nostafloor = new FlxSprite(40, 300).loadGraphic(Paths.image("muffin/nostafloor"));
    nostafloor.scale.set(1.2,1.6);
    nostafloor.scrollFactor.set(1,1);
    addBehindDad(nostafloor);

    muffingo = new FlxSprite(-1000,-100);
    muffingo.frames = Paths.getSparrowAtlas('muffin/muffingo');
    muffingo.animation.addByPrefix('go', "muffingo", 60, false);
    addBehindDad(muffingo);

    bopperss = new FlxSprite(0,-100);
    bopperss.frames = Paths.getSparrowAtlas('muffin/fellows');
    bopperss.animation.addByPrefix('bop', "boppers", 24, false);
    addBehindDad(bopperss);

    dustbehind = new FlxSprite(-300,-600);
    dustbehind.frames = Paths.getSparrowAtlas('muffin/dustbehind');
    dustbehind.animation.addByPrefix('bop', "fuckassdustbehind", 20, true);
    dustbehind.animation.play('bop');
    dustbehind.flipX = true;
    addBehindDad(dustbehind);

    mountains = new FlxSprite(-200, 0).loadGraphic(Paths.image("muffin/mountainsfar"));
    mountains.scale.set(1.2, 1.2);
    mountains.scrollFactor.set(0.4, 0.7);
    addBehindDad(mountains);

    mountains2 = new FlxSprite(-200, 0).loadGraphic(Paths.image("muffin/mountainsclose"));
    mountains2.scale.set(1.2, 1.2);
    mountains2.scrollFactor.set(0.6, 0.7);
    addBehindDad(mountains2);

    head2 = new FlxSprite(700,-300);
    head2.frames = Paths.getSparrowAtlas('muffin/realhead');
    head2.animation.addByPrefix('bop', "headasset", 24, false);
    head2.scale.set(.7,.7);
    head2.color = 0xFF909090;
    FlxTween.tween(head2, {y: -100}, 2.5,{ease: FlxEase.sineInOut,type: 4});
    addBehindDad(head2);
    
    floor = new FlxSprite(-200, 460).loadGraphic(Paths.image("muffin/floor"));
    floor.scale.set(1.2, 1.2);
    floor.scrollFactor.set(0.6, 0.7);
    addBehindDad(floor);

    clock = new FlxSprite(1500,-100);
    clock.frames = Paths.getSparrowAtlas('muffin/muffintimeclock');
    clock.animation.addByPrefix('thefunnyclock', "muffintimeclock", 60, true);
    clock.animation.play('thefunnyclock');
    clock.scale.set(1.1,1.1);
    clock.color = 0xFF909090;
    FlxTween.tween(clock, {y: -30}, 2.5,{ease: FlxEase.sineInOut,type: 4});
    FlxTween.tween(clock, {x: 1400}, 2.5,{ease: FlxEase.sineInOut,type: 4});
    addBehindDad(clock);

    dustfront = new FlxSprite(-100,-600);
    dustfront.frames = Paths.getSparrowAtlas('muffin/dustbehind');
    dustfront.animation.addByPrefix('bop', "fuckassdustbehind", 20, true);
    dustfront.animation.play('bop');
    dustfront.flipX = true;
    add(dustfront);

    nostafloor.alpha = bg.alpha = bopperss.alpha = muffingo.alpha = gf.alpha = mountains.alpha = mountains2.alpha = head2.alpha = floor.alpha = clock.alpha = dustbehind.alpha = dustfront.alpha = 0;
    
}
function postCreate(){
    //for camera
    defaultcamZoom = camera.zoom = camGame.zoom = .75;
}
function nosta(){
    head.alpha = 0;
    bg.alpha = nostafloor.alpha = bopperss.alpha = 1;
    dad.y = -200;
    dad.cameraOffset.y = 200;
}
function postUpdate(){
    healthBar.alpha = healthBarBG.alpha = iconP1.alpha = iconP2.alpha = 0;
}
//pauses video
function onSubstateOpen(event) {
    if (vid != null  && vid.alpha == 1 && paused)
        vid.pause(); 
}
function onSubstateClose(event){ 
    if (vid != null && vid.alpha == 1 &&  paused)
        vid.resume(); 
    }
function focusGained(){
    if (vid != null && vid.alpha == 1 && paused)
        vid.resume(); 
}
function beatHit(){
    beatShit();
}
function phase2(){
    nostafloor.alpha = bopperss.alpha = 0;
    mountains.alpha = mountains2.alpha = head2.alpha = floor.alpha = dustbehind.alpha = dustfront.alpha = 1;
    clock.alpha = 1;
    bg.loadGraphic(Paths.image("muffin/darkbg"));
    bg.x = -300;
    boyfriend.color = dad.color = 0xFF909090;
}
function beatShits(){
    if (curBeat % 1 == 0){
        bopperss.animation.play('bop');
    }
    if (curBeat % 2 ==0){
        head2.animation.play('bop');
    }
    if (curBeat == 138){
        muffingo.alpha = 1;
        muffingo.animation.play('go');
    }
    if (curBeat == 146){
        muffingo.animation.play('go');
    }
    if (curBeat == 154){
        muffingo.animation.play('go');
    }
    if (curBeat == 162 ){
        muffingo.animation.play('go');
    }
    if (curBeat == 170){
        muffingo.animation.play('go');
    }
    if (curBeat == 178){
        muffingo.animation.play('go'); 
    }
    if (curBeat == 186){
        muffingo.animation.play('go'); 
    }
    if (curBeat == 194){
        muffingo.animation.play('go'); 
    }   
}
function events(names){
    if (names == "fade"){
        FlxTween.tween(blackBarThingie2, {alpha: 1}, 26, {ease: FlxEase.circOut});
    }
    if (names == "nofade"){
        FlxTween.tween(blackBarThingie2, {alpha: 0}, 14, {ease: FlxEase.circOut});
    }
    if (names == "video"){
        vid.play();
        vid.alpha = 1;
        clock.alpha = 1;
        for (i in [scoreTxt, missesTxt, accuracyTxt]){
            i.alpha = 0;
        }   
    }
    if (names == "vidend"){
        remove(vid);
        blackBarThingie2.alpha = 1;
        FlxTween.tween(blackBarThingie2, {alpha: 0}, 3, {startDelay: 1 ,ease: FlxEase.circOut});
        for (i in [scoreTxt, missesTxt, accuracyTxt]){
            i.alpha = 1;
        }   
    }
    if (names == "fadeOut"){
        FlxTween.tween(blackBarThingie2, {alpha: 1}, 12, {ease: FlxEase.circOut});
    }
}