//this doesnt work but i'll just leave it here
import flixel.FlxG;
import flixel.util.FlxColor;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.util.FlxAxes;
import hxvlc.openfl.Video;
import hxvlc.flixel.FlxVideo;
import hxvlc.flixel.FlxVideoSprite;
introLength = -1;
var fakerBG:Array<FlxSprite> = [];
var scaryBG:Array<FlxSprite> = [];
var thirdBG:Array<FlxSprite> = [];
var playText:Alphabet;
var camOther = new FlxCamera();
var cutsceneText:FlxText;
var first = new FlxSprite().loadGraphic(Paths.image('stages/RodentRap/sunset/frontobjects'));
var Question = new FlxVideoSprite();
var BG2 = new FlxVideoSprite();
var introAnim:FlxSprite;
var cancelCameraMove:Bool = false;

function onCameraMove(e) if(cancelCameraMove) e.cancel();

function create(){


lyrics = new FlxText();
lyrics.setFormat(Paths.font("vcr.tff"), 48, FlxColor.WHITE, "center");
//lyrics.borderSize = 2;
lyrics.screenCenter(FlxAxes.X);
lyrics.y = FlxG.height - lyrics.height - 140;
lyrics.text = 'a';
add(lyrics);


lyrics.cameras = [camOther];

camOther.bgColor = 0;
camOther.alpha = 1;
FlxG.cameras.remove(camHUD, false);
FlxG.cameras.add(camHUD, false);
FlxG.cameras.add(camOther, false);

black = new FlxSprite();
black.makeGraphic(FlxG.width * 3,FlxG.height * 3,0xFF000000);
black.setGraphicSize(Std.int(FlxG.width *3),Std.int(FlxG.height * 3));
black.updateHitbox();
black.screenCenter();
black.cameras = [camOther];
black.alpha = 0.00000001;
add(black);


playText = new Alphabet(0,0,'Do you want to play with me?',true, false, 0.0, 0.7);
add(playText);
playText.screenCenter();
playText.cameras = [camOther];
playText.alpha = 0.000001;

var boringOffset = 50;
boring = new FlxSprite().loadGraphic(Paths.image('stages/RodentRap/obituary/boring'));
add(boring);
boring.scale.set(.7,.7);
boring.screenCenter();
boring.x += boringOffset;
boring.cameras = [camOther];

boringAlphabet = new Alphabet(0,0,"you're",true, false, 0.0);
add(boringAlphabet);
boringAlphabet.screenCenter();
boringAlphabet.x += -boring.width + boringOffset;
boringAlphabet.cameras = [camOther];

boringAlphabet2 = new Alphabet(0,0,"me",true, false, 0.0);
add(boringAlphabet2);
boringAlphabet2.screenCenter();
boringAlphabet2.x += (boring.width/1.25) + boringOffset;
boringAlphabet2.cameras = [camOther];

boring.alpha = black.alpha = boringAlphabet.alpha = boringAlphabet2.alpha = 0.00001;


if (FlxG.save.data.Videos){
Question.bitmap.onEndReached.add(Question.destroy);
Question.load(Assets.getPath(Paths.file("videos/cutscene-1.mp4")));
Question.scrollFactor.set();
Question.antialiasing = Options.antialiasing;
Question.cameras = [camHUD];
Question.alpha = 0.000001;
add(Question);
}

dad.alpha = 1;
addPhase1();    
addPhase2();  

}

function addPhase1() {
    introAnim = new FlxSprite(-22,362);
    introAnim.frames = Paths.getSparrowAtlas('stages/RodentRap/obituary/p1/Sonic_Turn');
    introAnim.antialiasing =Options.antialiasing;
    introAnim.animation.addByPrefix('intro', 'intro', 24, false);
    introAnim.animation.finishCallback = function (n:String) {
        dad.alpha = 1;
        introAnim.alpha = 0.00001;
        remove(introAnim);
        cancelCameraMove = false;
    }

    first.setGraphicSize(3885);
    first.updateHitbox();
    first.scrollFactor.set(1.25,1.25);
    first.screenCenter();
    first.x += 210 + 150;
    first.y += 400;
    insert(members.indexOf(healthBar) + 41, first);
    fakerBG.push(first);
    first.antialiasing = Options.antialiasing;

    insert(members.indexOf(dad), introAnim);
    
}
function addPhase2() {

rabbithead = new FlxSprite(320,515);
rabbithead.frames = Paths.getSparrowAtlas('stages/RodentRap/obituary/p1/Bunny_Kick');
rabbithead.animation.addByPrefix('play','rabbit head',24,false);
rabbithead.scale.set(.75,.75);
rabbithead.antialiasing = Options.antialiasing;
add(rabbithead);
scaryBG.push(rabbithead);

rabbithead.animation.finishCallback = function (n:String) {
    remove(rabbithead);
}

kickingAnim = new FlxSprite(-160,275);
kickingAnim.frames = Paths.getSparrowAtlas('stages/RodentRap/obituary/p1/X_Kick');
kickingAnim.antialiasing = Options.antialiasing;
kickingAnim.animation.addByIndices('kick', 'kickx', [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22], "", 24, false);
kickingAnim.animation.addByIndices('laugh', 'kickx', [21,22,23,24,25], "", 24, false);
kickingAnim.animation.addByIndices('return', 'kickx', [26,27], "", 24, false);
kickingAnim.scale.set(.9,.9);
insert(16,kickingAnim);
kickingAnim.alpha = 0.00001;

kickingAnim.animation.finishCallback = function (n:String) {
    if (n == 'return') remove(kickingAnim);
}

var birdsAnim = new FlxSprite();
birdsAnim.frames = Paths.getSparrowAtlas('stages/RodentRap/obituary/p1/birds1');
birdsAnim.animation.addByPrefix('i', 'birds', 12, true);
birdsAnim.animation.play('i');
rabbithead.scale.set(.765,.765);
birdsAnim.screenCenter();
birdsAnim.y += 30 + treeOffset[1];
birdsAnim.x += -55+ treeOffset[0];
birdsAnim.antialiasing = Options.antialiasing;
add(birdsAnim);
scaryBG.push(birdsAnim);


//setgraphicsize stuff
var f = new FlxSprite();
f.frames = Paths.getSparrowAtlas('stages/RodentRap/obituary/p1/bgFiles');
f.animation.addByPrefix('i','frontshit',24);
f.animation.play('i');
f.setGraphicSize(3885);
f.updateHitbox();
f.scrollFactor.set(1.25,1.25);
f.screenCenter();
f.x += 210 + 150;
f.y += 400;
add(f);
scaryBG.push(f);
f.antialiasing = Options.antialiasing;
}

function singing(words){
    trace(words);
    lyrics.text = words;
    lyrics.screenCenter(FlxAxes.X);       
}

function events(eventName){
    if (eventName == '1st-vid') {
        cancelCameraMove = true;
        var spr = fakerBG[fakerBG.length-1];
        var time = 0.2;
        var delay = 0.2;
        //og y 616;
        FlxTween.tween(spr, {alpha: 0.3},time, {ease: FlxEase.quadIn, startDelay: delay});
        FlxTween.tween(camFollow, {x: 350, y: 580},time, {ease: FlxEase.quadIn, startDelay: delay});
        FlxTween.tween(camGame, {zoom: 1.5},time, {ease: FlxEase.quadIn, startDelay: delay, onComplete: function (f:FlxTween) {
            spr.alpha = 1;
            Question.alpha = 1;
            Question.play();
            canPause = false;
            camHUD.zoom = 1.05;
            FlxTween.tween(camHUD,{zoom: 1},0.4, {ease: FlxEase.quadOut});
        }});

    }
    if (eventName == 'look-right') {
    FlxTween.tween(camFollow, {x: 500},0.7, {ease: FlxEase.sineInOut});
    FlxTween.tween(camGame, {zoom: 1.},0.7, {ease: FlxEase.sineInOut});
    FlxTween.tween(first, {alpha: 1},0.7, {ease: FlxEase.sineInOut});
    }
    if (eventName == 'begin') {
    FlxTween.tween(camFollow, {x: 400},0.7, {ease: FlxEase.sineInOut});
    FlxTween.tween(camFollow, {y: 500},0.7, {ease: FlxEase.sineInOut});
    FlxTween.tween(camGame, {zoom: 0.65},1.3, {ease: FlxEase.sineInOut});
    
    camHUD.zoom = 1.2;
    FlxTween.tween(camHUD, {alpha: 1,zoom: 1},1.3, {ease: FlxEase.sineInOut, onComplete: function (f:FlxTween) {
        cancelCameraMove = false;
    }});   
}    
    if (eventName == 'im hungry') {
        canPause = true;
            camHUD.alpha = 0.0001;
            FlxG.camera.zoom = 0.65;
            defaultCamZoom = 0.65;
            camOther.zoom = 0.8;
            FlxTween.tween(camGame, {zoom: 0.8},1, {ease: FlxEase.quadInOut});
            new FlxTimer().start(0.1, Void -> {
             for(i in fakerBG){
                 i.color = 0xFFFFFFFF;
                 i.alpha = 1;
                 FlxTween.color(i, 0.75, 0xFFFFFFFF, 0xFF464646, {ease: FlxEase.quadInOut});
                }
                new FlxTimer().start(0.05,Void-> {
                        dad.animation.play('idle-alt', true);

                    });

                });
                dad.animation.finishCallback = function(shit:String){
                    dad.animation.play('idle-alt-evil');
                };

                new FlxTimer().start(0.6,Void-> {
                playText.alpha = 1;
                camGame.alpha = 0.000001;

                });
            }
            if (eventName == '2') {
            introAnim.alpha = 0;
            cancelCameraMove = false;
            playText.alpha = 0;
            camGame.alpha = 1;
            camHUD.alpha = 1;
            
            for(i in fakerBG){
                i.visible = false;
                FlxTween.color(i, 0.1, 0xFF606060, 0xFF000000, {ease: FlxEase.quadInOut});                    
            }
            for(i in scaryBG){
                i.visible = true;                  
            }
            BG2.play();
        }
        if (eventName == 'pre-kick') {
            var x = dad.getMidpoint().x + 150;
            var y = dad.getMidpoint().y - 100;
            y += 100;
            x += 100;
            cancelCameraMove = true;

            FlxTween.tween(camFollow, {x: x,y: y},0.2, {ease: FlxEase.sineInOut});
        }
        if (eventName == 'kick') {
            dad.alpha = 0.00001;
            kickingAnim.alpha = 1;
            kickingAnim.animation.play('kick');
            FlxG.sound.play(Paths.sound('RT/windUpKick'),1);
            rabbithead.animation.play('play');

            rabbithead.animation.finishCallback = function (n:String) {
                rabbithead.alpha = 0.00001;
            }
            new FlxTimer().start(1, Void -> {
            kickingAnim.animation.play('laugh',true);
            });
            new FlxTimer().start(1.3, Void -> {
                kickingAnim.animation.play('laugh',true);
            });
            new FlxTimer().start(1.6, Void -> {
            dad.alpha = 1;
            kickingAnim.alpha = 0.0001;
            cancelCameraMove = false;
         });   
        }
        if (eventName == 'stare') {
            dad.playAnim('gameover');
            dad.animation.curAnim.pause();
            new FlxTimer().start(.5, Void -> {
            boring.alpha = black.alpha = boringAlphabet.alpha = boringAlphabet2.alpha = 1;
            });
            new FlxTimer().start(2, Void -> {
            boring.alpha = black.alpha = boringAlphabet.alpha = boringAlphabet2.alpha = 0.00001;
            });
        }
        
    }
    function onStartCountdown(){
    var x = 260;
    var y = 390;
    black.alpha = 1;
    cancelCameraMove = true;
    camFollow.setPosition(x,y);
    }
    function onCountdown(event)
    event.cancel();
    function onStartCountdown(){
        var x = 260;
        var y = 390;
        black.alpha = 1;
        cancelCameraMove = true;
        camFollow.setPosition(x,y);
        }
        function onCountdown(event)
        event.cancel();
        
        function onSongStart(){
            barSongLength = 92250;
            camHUD.alpha = 0;
        
            var x = 260;
            var y = 350;
            cancelCameraMove = true;
            camFollow.setPosition(x,y);
            camGame.zoom = 1.25;
            exampleTween = FlxTween.tween(camFollow, {y: 616},0.4, {ease: FlxEase.sineInOut,startDelay: 0.1});
            
            FlxTween.tween(black, {alpha: 0.00001},0.5, {ease: FlxEase.sineInOut});
            FlxTween.tween(first, {alpha: 0.3},1.2);
        
            introAnim.alpha = 1;
            dad.alpha = 0.0000001;
            introAnim.animation.play('intro');
        }
