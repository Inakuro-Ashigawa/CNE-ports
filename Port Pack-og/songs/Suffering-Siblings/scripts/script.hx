import Date;
import flixel.FlxCamera;
import funkin.backend.FunkinSprite;
import funkin.backend.FunkinText;
import funkin.game.HealthIcon;
var blackboxDown = new FlxSprite();
var blackboxUp = new FlxSprite();
var tweens:Array<FlxTween> = [];
var leDate:Date = Date.now();
var camCard:FlxCamera;
var  CNlogo = new FunkinSprite();
public var bfIntro:Character;
public var pibbyIntro:Character;
var sognArtist:String = 'Awe (ft. Saster)';

function update() {
    if(curCameraTarget == 0){
        defaultCamZoom = 0.85;
    }
    if(curCameraTarget == 1){
        defaultCamZoom = 1.0;
    }
    if(curCameraTarget == 2){
        defaultCamZoom = 0.9;
    }
    if(curCameraTarget == 3){
        defaultCamZoom = 1.0;
      }
}
function postCreate() {
    FlxG.cameras.add(camCard = new HudCamera(), false);
    camCard.bgColor = FlxColor.TRANSPARENT;

         CNlogo = new FlxSprite(990, 600);
         CNlogo.loadGraphic(Paths.image(" CNlogo"));
	 CNlogo.setGraphicSize(Std.int( CNlogo.width * 0.17));
	 CNlogo.updateHitbox();
         CNlogo.alpha = 0.5;
         CNlogo.cameras = [camCard];
         add(CNlogo);

          var leDate = Date.now();
		if (leDate.getHours() >= 17 && leDate.getHours() <= 24) {
			 CNlogo.loadGraphic(Paths.image('aslogo'));
			 CNlogo.x = 1046.5;
			 CNlogo.y = 660;
			 CNlogo.setGraphicSize(Std.int( CNlogo.width * 0.09));
			 CNlogo.updateHitbox();
			 
			trace( CNlogo.y);
		}

		if (leDate.getHours() >= 1 && leDate.getHours() <= 6) {
			 CNlogo.loadGraphic(Paths.image('aslogo'));
			 CNlogo.x = 1046.5;
			 CNlogo.y = 660;
			 CNlogo.setGraphicSize(Std.int( CNlogo.width * 0.09));
			 CNlogo.updateHitbox();
			 
		}

		if (leDate.getHours() >= 6 && leDate.getHours() <= 17) {
			 CNlogo.loadGraphic(Paths.image('CNlogo'));
			 CNlogo.x = 990;
			 CNlogo.y = 600;
			 CNlogo.setGraphicSize(Std.int( CNlogo.width * 0.17));
			 CNlogo.updateHitbox();
			 
		}

}
function create(){
    
        window.title = "Pibby: Apocalypse - " + curSong + " - Composed by " + sognArtist;

        remove(strumLines.members[0].characters[0]);
	remove(strumLines.members[3].characters[0]);

	add(strumLines.members[3].characters[0]);
	add(strumLines.members[0].characters[0]);
    

    

}
function stepHit(){
  switch(curStep){
   case 128, 160, 192, 256, 384, 448, 504, 512, 576, 640, 704, 768, 832, 896, 960, 1024, 1088, 1280, 1408, 1472:
    camGame.flash();
 case 1536, 1600, 2080, 2336, 2368, 2400, 2464, 2528, 2592, 2656, 2720, 2784, 2848, 2912, 2976, 3008, 3040, 3104, 3168:
    camGame.flash();
case 3224, 3296, 3648:
    camGame.flash();
case 3232:
    camGame.flash(FlxColor.WHITE, 1.2);
case 3360, 3392:
    camHUD.flash();
case 1152:
    camGame.flash(FlxColor.BLACK, 2.5);
case 1664:
    camGame.flash(FlxColor.BLACK, 10);
    camHUD.flash();
}

if (curStep == 3776){
camGame.alpha = 0.0001;
}

if (curStep == 128){
camMoving = true;
}
}
function update(){
if(downscroll){
      CNlogo.y -= 530;
 }
}
//Health Drain Shits
function onDadHit(note:NoteHitEvent){
 if (health > 0.1) {health -= 0.017;}}
