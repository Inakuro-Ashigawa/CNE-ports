var blackboxUp = new FlxSprite();
var blackboxDown = new FlxSprite();
public var bfIntro:Character;
public var pibbyIntro:Character;
public var countNum = new FlxSprite();
public var camMoving:Bool = true;

// camera Angle move when playing left and right anims
var camAngle = 0;

// introSounds
introSounds = ['PA/1', 'PA/2', 'PA/3', 'PA/go'];

// for 3,2,1,GO images, I made it null since the thingy is animated
introSprites = [null, null, null, null];

// how long does the intro thingy ends
introLength = 6;

function create(){
    blackboxDown.makeGraphic(FlxG.width * 20, 1000,  0xFF000000);
    blackboxDown.y = 900;

    blackboxUp.makeGraphic(FlxG.width * 20, 1000,  0xFF000000);
    blackboxUp.y -= 1000;
    blackboxDown.cameras = [camHUD];
    blackboxUp.cameras = [camHUD];
    insert(1, blackboxDown);
    insert(1, blackboxUp);
}
function stepHit(){

    if (curStep == 3776){
        camGame.alpha = 0.0001;
    }
    if (curStep == 1 || curStep == 768 || curStep == 1408 || curStep == 2336 || curStep == 2448 || curStep == 2976){
        FlxTween.tween(blackboxDown, {y: 625}, 0.2, {ease: FlxEase.quadInOut});
        FlxTween.tween(blackboxUp, {y: - 925}, 0.2, {ease: FlxEase.quadInOut});
    }
    if (curStep == 1696){
        FlxTween.tween(blackboxDown, {y: 625}, 0.4, {ease: FlxEase.quadInOut});
        FlxTween.tween(blackboxUp, {y: - 925}, 0.4, {ease: FlxEase.quadInOut});
    }
    if (curStep == 2400){
        FlxTween.tween(blackboxDown, {y: 900}, 0.4, {ease: FlxEase.quadInOut});
        FlxTween.tween(blackboxUp, {y: - 1000}, 0.4, {ease: FlxEase.quadInOut});
    }
    if (curStep == 2374 || curStep == 2432){
        FlxTween.tween(blackboxDown, {y: 500}, 0.2, {ease: FlxEase.quadInOut});
        FlxTween.tween(blackboxUp, {y: - 800}, 0.2, {ease: FlxEase.quadInOut});
    }
    if (curStep == 384 || curStep == 1024 || curStep == 1664 || curStep == 1952 || curStep == 2720){
        FlxTween.tween(blackboxDown, {y: 900}, 0.2, {ease: FlxEase.quadInOut});
        FlxTween.tween(blackboxUp, {y: - 1000}, 0.2, {ease: FlxEase.quadInOut});
    }
  }

function postUpdate(){
 if (camMoving){
    switch (strumLines.members[curCameraTarget].characters[0].getAnimName()) {
        case "singLEFT": 
        camFollow.x -= 20;
        camAngle = -1;
        case "singDOWN": 
        camFollow.y += 20;
        case "singUP": 
        camFollow.y -= 20;
        case "singRIGHT": 
        camFollow.x +=20;
        camAngle = 1;
    }
    if (camAngle != 0) {camAngle = (lerp(camAngle, 0, 0.088));}
    camera.angle = (lerp(camera.angle, camAngle, 0.088));
    }


}


