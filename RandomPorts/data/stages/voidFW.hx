var alphaStuff = FlxG.random.float(1,8);
var pixel = new CustomShader("pixelated");
var thatOtherPixel = new CustomShader("pixelated");
var file = new CustomShader("fileShader");
var glitchScreen = new CustomShader("fwGlitch");
var blackBarThingie,blackBarThingie2:FlxSprite;
var timerShit;
function create(){
    //camGame.alpha = 0.001;
    boyfriend.cameraOffset.x = -400;

    pixel.size = 10;

    house.angle = 3;
    houseb.angle = 3;
    houseb.y = -579.5;
    FlxTween.tween(void, {alpha: alphaStuff/3}, 0.15, {ease: FlxEase.linear, type: 4});
    FlxTween.tween(bg, {angle: -0.7},5, {ease: FlxEase.sineInOut, type: 4});

    FlxTween.tween(house, {angle: 20},2.5, {ease: FlxEase.sineInOut, type: 4});
    FlxTween.tween(house, {y: -330}, 5, {ease: FlxEase.sineInOut, type: 4});
    FlxTween.tween(houseb, {y: -330}, 5, {ease: FlxEase.sineInOut, type: 4});
    FlxTween.tween(houseb, {angle: 20}, 2.5, {ease: FlxEase.sineInOut, type: 4});

    blackBarThingie = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    blackBarThingie.setGraphicSize(Std.int(blackBarThingie.width * 10));
    blackBarThingie.alpha = 1;
    insert(members.indexOf(dad) , blackBarThingie);
    boyfriend.angle = dad.angle = bg.angle; 

  
    blackBarThingie2 = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    blackBarThingie2.setGraphicSize(Std.int(blackBarThingie2.width * 10));
    blackBarThingie2.alpha = 1;
    blackBarThingie2.cameras = [camHUD];
    add(blackBarThingie2);

    //shaders
    glitch1.shader = glitch2.shader = pixel;
    void1.shader = void.shader = glitches;

    makeShitInsane(houseb, 9000, .4, 9);
    houseb.alpha = 0;

}
function postCreate(){
	remove(scoreTxt);
	remove(missesTxt);
	remove(accuracyTxt);

    comboRatings = [];
}  

function badend(){
    camHUD.alpha = camGame.alpha = 1;
    camHUD.flash();
    camGame.flash();
    void.shader = file;
    void1.shader = file;
    houseb.alpha = 1;
    house.alpha = 0;
    void1.shader = void.shader = null;
    new FlxTimer().start(1, function(tmr:FlxTimer)
    {
        void1.shader = void.shader = file;
    });
}
function makeShitInsane(object, xThing, timerRandom1, timerRandom2)
    {
        FlxTween.tween(object, {x: object.x + xThing}, timerShit, {
            ease: FlxEase.sineInOut,
            onComplete: 
            function(e)
            {
                timerShit = FlxG.random.float(timerRandom1, timerRandom2);
                object.x = -3492.5;
                object.scale.x = FlxG.random.float(0.75, 1.1);
                object.scale.y = object.scale.x;
                makeShitInsane(object, xThing, timerRandom1, timerRandom2);
            }
        });
    }
    
    
var time:Float = 0;
function update(elapsed){
    boyfriend.angle = dad.angle = bg.angle; 
    time += elapsed;
    
    glitchScreen.iTime = time;
    file.iTime = time;
}
function beatHit(){
    // funni glitch shader lmao
    pixel.size = FlxG.random.int(5, 15);
}
function postUpdate(){
    boyfriend.cameraOffset.x = -400;
}
function postCreate(){
    defaultcamZoom = camGame.zoom = .7;
}
//heath drain and other shits
function onDadHit(note:NoteHitEvent) {
    void1.alpha = 0.001;
    void.alpha = 1;
    if (health > 0.1) {
        note.healthGain = 0.04;
    }
}
function onPlayerHit(){
    void.alpha = 0.001;
    void1.alpha = 1;
}

function onSongStart(){
    FlxTween.tween(blackBarThingie2, {alpha: 0}, 5, {ease: FlxEase.sineIn});
    //camGame.alpha = 1;
}
function fadein(){
    FlxTween.tween(blackBarThingie2, {alpha: 1}, 1, {ease: FlxEase.sineIn});
}
function back(){
    blackBarThingie2.alpha = 0;
}
function camBack(){
    camGame.shake(0.01, 1);
    camGame.alpha = 1;
    camGame.flash();
    appear();
    blackBarThingie.alpha = 0;
}
function camFade(){
    FlxTween.tween(camGame, {alpha: 0}, .4, {ease: FlxEase.sineIn});
}