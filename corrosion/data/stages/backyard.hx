import hxvlc.openfl.Video;
import openfl.text.TextField;
import openfl.text.TextFormat;
import hxvlc.flixel.FlxVideoSprite;
import flixel.text.FlxTextBorderStyle;
import flixel.effects.particles.FlxTypedEmitter;
import flixel.effects.particles.FlxEmitter.FlxEmitterMode;

var bf;
var emitter:FlxTypedEmitter;
var emitter2:FlxTypedEmitter;
var vid = new FlxVideoSprite();
var camVid:FlxCamera;
var blackBarThingie2:FlxSprite;
var cutscene:Bool = false;

function create() {
    camVid = new FlxCamera();
	camVid.bgColor = 0;
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(camVid, false);
	FlxG.cameras.add(camHUD, false);

    vid.load(Assets.getPath(Paths.file("videos/corrosion.mp4")));  
    vid.camera = camVid;
    add(vid);
    vid.play();
    vid.pause();
    vid.alpha = 0.000001;

    bf = boyfriend;
    bf.cameraOffset.x = -200;

    emitter = new FlxTypedEmitter(500, 1500, 100);
    emitter.width = FlxG.width;
    emitter.launchMode = FlxEmitterMode.SQUARE;
    emitter.width = FlxG.width;
    emitter.scale.set(2,2);
    emitter.alpha.set(1,0);
    emitter.velocity.set(-50, -150, 50, -750, -100, 0, 100, -100);
    add(emitter);
    emitter.loadParticles(Paths.image('stages/backyard/glow_red1'), 500, 50, true);

    emitter2 = new FlxTypedEmitter(500, 1500, 100);
    emitter2.width = FlxG.width;
    emitter2.launchMode = FlxEmitterMode.SQUARE;
    emitter2.width = FlxG.width;
    emitter2.scale.set(2,2);
    emitter2.alpha.set(1,0);
    emitter2.velocity.set(-50, -150, 50, -750, -100, 0, 100, -100);
    add(emitter2);
    emitter2.loadParticles(Paths.image('stages/backyard/glow_pink'), 500, 50, true);

    blackBarThingie2 = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    blackBarThingie2.setGraphicSize(Std.int(blackBarThingie2.width * 10));
    blackBarThingie2.alpha = 0;
    blackBarThingie2.cameras = [camGame];
    add(blackBarThingie2);
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
function video(){
    cutscene = true;
    vid.play();
    vid.alpha = camHUD.alpha = 1;
    for (i in playerStrums.members){
        i.alpha = 0; 
    }
    for (i in [scoreTxt, missesTxt, accuracyTxt]){
        i.alpha = 0;
    }    
}
function black(){
    camGame.alpha = 0;
}
function postUpdate(){
    if (cutscene){
        for (i in cpuStrums.members){
            healthBar.alpha = iconP1.alpha = iconP2.alpha = healthBarBG.alpha = i.alpha = 0;
            i.x = 9999;
        }
    }
}
function postCreate(){
    lyrics = new FlxText();
    lyrics.setFormat(Paths.font("graphite.otf"),48, 0xFFFF55F5, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    lyrics.borderSize = 2;
    lyrics.cameras = [camHUD];
    lyrics.screenCenter(FlxAxes.X);
    lyrics.y = FlxG.height - lyrics.height - 200;
    lyrics.text = '';
    add(lyrics);
}
function phase2(){
    flame.alpha = bg_realphase2.alpha = 1;
    bg_fake.alpha = 0;
    bg_skyphase2.alpha = .3;
    camGame.alpha = 1;
    emitter.start(false);
}
function fade(){
    FlxTween.tween(blackBarThingie2, {alpha: 1}, 0.4, {ease: FlxEase.circOut});
    FlxTween.tween(camHUD, {alpha: 0}, 0.5, {ease: FlxEase.circOut});
}
function noteFade(){
    for (i in playerStrums.members)
        FlxTween.tween(i, {alpha: 1}, 0.4, {ease: FlxEase.circOut});
}
function backCut(){
    blackBarThingie2.alpha = bg_realphase2.alpha = bg_realphase2.alpha= 0;
    bg_realphase3.alpha = 1;
    bg_skyphase3.alpha = .3;
}
function pink(){
    emitter2.start(false);
    remove(emitter);

    bg_skyphase3.alpha = flame_pink.alpha = bg_realphase3.alpha = flame.alpha = 0;
    bg_realphase3_p.alpha = flame_pink.alpha = 1;
    bg_skyphase3_p.alpha = .3;
}
function back2(){
    remove(emitter2);
    add(emitter);

    bg_skyphase3.alpha = flame_pink.alpha = bg_skyphase3_p.alpha = 0;

    bg_realphase3.alpha = flame.alpha = 1;
    bg_skyphase3.alpha = .3;
}
function end(){
    camGame.fade(FlxColor.BLACK, 22);
}
function vidend(){
    remove(vid);
    blackBarThingie2.alpha = 1;
}
function back23(){
    blackBarThingie2.alpha = 0;
}
function singing(words){
    trace(words);
    lyrics.text = words;
    lyrics.screenCenter(FlxAxes.X);       
}
function fadewords(){
    FlxTween.tween(lyrics, {alpha: 0}, 9, {ease: FlxEase.circOut});
}