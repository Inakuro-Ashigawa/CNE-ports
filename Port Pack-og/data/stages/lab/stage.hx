// uhh yeah.. fuck it
import openfl.geom.ColorTransform;
import funkin.game.HealthIcon;

var flickerTween:Array<FlxTween> = [];
var flickerTween2:Array<FlxTween> = [];
var jakeIcons:HealthIcon;
var centerCams:Bool = false;
public var lowMem = Options.lowMemoryMode;

function create()
{
 

    if (!lowMem){
	flickerTween = FlxTween.tween(light, {alpha: 0}, 0.25, {ease: FlxEase.bounceInOut, type: 4});
	flickerTween.active = true;

	flickerTween2 = FlxTween.tween(light, {alpha: 0}, 0.25, {ease: FlxEase.bounceInOut, type: 4});
	flickerTween2.active = true;
    }

    if (!lowMem){
    insert(members.indexOf(boyfriend), light);
    insert(members.indexOf(boyfriend), dark);
    insert(members.indexOf(boyfriend), bulb);
    }
    
      strumLines.members[0].characters[0].x = 1030;
   }
function postCreate(){
    if (curSong == 'suffering-siblings'){
    var dad2nd = strumLines.members[3].characters[0];

    jakeIcons = new HealthIcon(dad2nd.icon!=null?dad2nd.icon:dad2nd.curCharacter);
    jakeIcons.visible = true;
    jakeIcons.cameras = [camHUD];
    jakeIcons.health = health;
    insert(members.indexOf(healthBar) + 2, jakeIcons);

    jakeIcons.x = 200;
    jakeIcons.y = iconP1.y;
    }
}
function onEvent(e) {
    if (e.event.name == "AppleFilter-Alt"){
    if (e.event.params[0] == true || e.event.params[0] == null){
        bg.alpha = 0.0001;
        
        if (!lowMem){
        light.alpha = 0.0001;
        bulb.alpha = 0.0001;
        dark.alpha = 0.0001;
        flickerTween.active = false;
        flickerTween2.active = false;
        }
    } else if (e.event.params[0] == false){
        bg.alpha = 1;
        
        if (!lowMem){
        light.alpha = 1;
        bulb.alpha = 1;
        dark.alpha = 1;
        flickerTween.active = true;
        flickerTween2.active = true;
        }
    }}
}

function postUpdate(elapsed) {
    if (!lowMem){
	light.angle = Math.sin((Conductor.songPosition / 1000) * (Conductor.bpm / 60) * 1.0) * 5;
	dark.angle = light.angle;
	bulb.angle = light.angle;
    }
    
    if (curSong == 'suffering-siblings'){
    jakeIcons.scale.x = iconP1.scale.x;
    jakeIcons.scale.y = iconP1.scale.y;
    }

    if (centerCams){
        camFollow.x = 1700;
    }
}

function stepHit(curStep){
       if (curStep == 1664){
        camGame.flash(0x000000, 16);
        //camHUD.flash();
    }

    if (curStep == 1696){
        boyfriend.alpha = 0.6;
        dad.alpha =  0.6;
    }

    if (curStep == 1824){
        dad.alpha = 1;
    }

    if (curStep == 2080){
        boyfriend.alpha = 1;
    }

    if (curStep == 2080){
        //camHUD.flash();
        centerCams = true;
        FlxTween.tween(camera, {zoom: 0.6}, 20);
        gf.alpha = 0.0001;
        strumLines.members[3].characters[0].alpha = 0.0001;
        bg.alpha = 0.0001;
        
        if (!lowMem){
            light.alpha = 0.0001;
            bulb.alpha = 0.0001;
            dark.alpha = 0.0001;
            flickerTween.active = false;
            flickerTween2.active = false;
        }
    }

    if (curStep == 2336){
        //camHUD.flash();
        gf.alpha = 1;
        strumLines.members[3].characters[0].alpha = 1;
        bg.alpha = 1;
        
        if (!lowMem){
            light.alpha = 1;
            bulb.alpha = 1;
            dark.alpha = 1;
            flickerTween.active = true;
            flickerTween2.active = true;
        }
    }

    if (curStep == 2400){
        centerCams = false;
    }

    if (curStep == 3360){
        camGame.alpha = 0.0001;
        //camHUD.flash();
    }

    if (curStep == 3392){
        //camHUD.flash();
        camGame.alpha = 1;
        dad.visible = false;
        strumLines.members[3].characters[0].alpha = 0.0001;
    
 }
}