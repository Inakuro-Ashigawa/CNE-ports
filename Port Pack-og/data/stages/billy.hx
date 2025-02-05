import hxvlc.openfl.Video;
import hxvlc.flixel.FlxVideo;
import hxvlc.flixel.FlxVideoSprite;
import flixel.util.FlxTimer;
import flxanimate.FlxAnimate;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import openfl.filters.ShaderFilter;

var blue:CustomShader;
var note = new CustomShader('Silly/3D');

var StrumsCamera = new FlxCamera(); 

introLength = -10;
var bars:FlxSprite;
var camExtra:FlxCamera;
var cutsceneCamera:FlxCamera;
var camZoomLock:Bool = false;
var lyric:FlxSprite;
var MyWay = new FlxVideoSprite();
var dadZoom:Float = 0.625;
var bfZoom:Float = .5;

function create() {
//player.cpu = true;


blue = new CustomShader('Silly/blue');
blue.hue = 1.3;
blue.pix = 0.00001;

if (FlxG.save.data.Videos){
Opening = new FlxVideo();
Opening.onEndReached.add(Opening.dispose);
Opening.load(Assets.getPath(Paths.file("videos/Silly/open.mp4")));


MyWay.load(Assets.getPath(Paths.file("videos/Silly/SO_STAY_FINAL.mp4")));  
MyWay.cameras = [camGame];
MyWay.screenCenter();
MyWay.y += 250;
MyWay.x += 112;
MyWay.scale.x = 2;
MyWay.scale.y = 2;
MyWay.alpha = 0.0000001;
add(MyWay);
}

lyric  = new FlxSprite(910 + 45, 600 + -5);
lyric.frames = Paths.getFrames('misc/lyric/lyric');
lyric.animation.addByPrefix('Proud', 'billy', 27 ,false);
lyric.antialiasing = true;
lyric.scale.x = 1.37;
lyric.scale.y = 1.37;
lyric.alpha = 0.0000001;
insert(11, lyric);

bars = new FlxSprite().loadGraphic(Paths.image('misc/bars'));
bars.cameras = [camHUD];
add(bars);

lyrics = new FlxText();
lyrics.setFormat(Paths.font("Times New Roman.ttff"), 48, 0xFFcfa92d,FlxTextBorderStyle.OUTLINE, "center");
lyrics.borderSize = 2;
lyrics.cameras = [camHUD];
lyrics.screenCenter(FlxAxes.X);
lyrics.y = FlxG.height - lyrics.height;
lyrics.text = '';
add(lyrics);

blackScreen = new FlxSprite().makeGraphic(1, 1, 0xFF000000);
blackScreen.scale.set(FlxG.width * 2,FlxG.height * 2);
blackScreen.updateHitbox();
blackScreen.scrollFactor.set();
blackScreen.screenCenter();
blackScreen.alpha = 0;
add(blackScreen);

broken.useColorTransform = true;


}

function onCountdown(event)
event.cancel();
camGame.alpha = 0.00000000000001;
camHUD.alpha = 0.00000000000001;

function onSongStart(){
if (FlxG.save.data.Videos)//Opening.play();
camGame.alpha = 1;
camHUD.alpha = 1;
}
function fadein(){
FlxTween.tween(camHUD, {alpha: 1}, 2, {ease: FlxEase.quartOut});
}

function update(elapsed:Float){
 if (camZoomLock) return;
    switch (curCameraTarget){
        case 0: defaultCamZoom = dadZoom;
        case 1: defaultCamZoom = bfZoom;
    }
}
function things(eventName, value1){
if(eventName == "ill make"){
  switch(value1){
    case 'vid':
        trace('hi!');
        if (FlxG.save.data.Videos)MyWay.play();
        vocals.volume = 0;
        inst.volume = 1;
        camHUD.alpha = 1;
        lyric.alpha = 0.0000000000000000001;
        dad.alpha = 1;
        MyWay.alpha = 1;
        camGame.flash(0xFF000000, 2);
        camGame.zoom = 1.1;   
        blackScreen.alpha = 0;
        defaultCamZoom = 0.5;

     case 'black':
         FlxTween.tween(blackScreen, {alpha: 1}, .8, {ease: FlxEase.quadOut});
         FlxTween.num(0.6, 1.125, 0.75, {ease: FlxEase.backIn, onUpdate: (s:FlxTween)->{
         defaultCamZoom = s.value;
         }});
      case 'pre':
      var shit = [scoreTxt];
      playerStrums.forEach(function(spr)
      {
	shit.push(spr);
      });
      cpuStrums.forEach(function(spr)
      {
	shit.push(spr);
      });

      for(s in shit){ FlxTween.tween(s, {alpha: 0}, 2, {ease: FlxEase.quadIn}); }
      camZoomLock = true;
      defaultCamZoom = 0.5;

    case 'anim':    
        vocals.volume = 4;
        inst.volume = 1.2;
        lyric.alpha = 1;
        dad.alpha = 0.0000000001;
        lyric.animation.play('Proud');
        for (i in playerStrums.members) 
	FlxTween.tween(i, {x: i.x - 300}, .01, {ease: FlxEase.smootherStepInOut});

    case 'break mirror':
        normal.alpha = 0.0000000000001;
        FlxTween.num(255, 0, 1.75, {ease: FlxEase.quadOut, onUpdate: function(twn)        {       broken.setColorTransform(1,1,1,1,twn.value,twn.value,twn.value,0); } } );
        camera.shake(0.01, 0.25);
        camGame.shake(0.01, 0.25);
        FlxG.sound.play(Paths.sound("mirror_break"));

     case 'no-vid':
        if (FlxG.save.data.Videos)remove(MyWay);
        blackScreen.alpha = 1;
        FlxG.camera.addShader(blue);
    case 'fadein':
        for (i in playerStrums.members) 
	FlxTween.tween(i, {alpha:1}, 2, {ease: FlxEase.smootherStepInOut});

    case 'fadeout':
         FlxTween.tween(blackScreen, {alpha: 0}, 2, {ease: FlxEase.quadOut});
         for (i in playerStrums.members) 
	FlxTween.tween(i, {x: i.x + 300}, 2, {ease: FlxEase.smootherStepInOut});


  }
 }
}
function postCreate(){
    healthBar.visible = false;
    healthBarBG.visible = false;
    iconP2.visible = false;
    for (i in [scoreTxt, missesTxt, accuracyTxt])
     i.y -= 40;

    var vig = new FlxSprite().loadGraphic(Paths.image('misc/vignette'));
    vig.cameras = [camHUD];
    add(vig);
}
function setzoom(zoom){
defaultCamZoom = zoom;
FlxG.camera.zoom = zoom;
}
function postUpdate(){
   iconP2.x = -999;
}
function singing(words){
trace(words);
lyrics.text = words;
lyrics.screenCenter(FlxAxes.X);       
}