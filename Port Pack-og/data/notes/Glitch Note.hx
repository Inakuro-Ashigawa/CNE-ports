// for noteType stuff
// NO TOUCHIES MAFAKA >:(
import StringTools;

var singDir = ["LEFT", "DOWN", "UP", "RIGHT"];
var glitching:Bool = false;

function onNoteHit(note){

    var curNotes = note.noteType;

    switch(curNotes) {

    case "Glitch Note":
        camera.shake(0.008, 0.04);
        camHUD.shake(0.008, 0.04);
        shakes();

        distorShit = 0.125;
        glitching = !glitching;
        if (Options.gameplayShaders){
            if (!note.note.isSustainNote){
            distorDad.binaryIntensity = FlxG.random.float(-1, -0.5);

            // will make all of dads character glitching if you want them to not popping up just do [visible = false;]
            for (dads in strumLines.members[0].characters){
                if (dads.shader == null)dads.shader = distorDad;
            }
                distorDad.negativity = (note.note.sustainLength > 0 ? note.note.sustainLength/1000 : 0) + FlxG.random.float(1.0, 2.0);
            }

                if (FlxG.random.float(0, 1) < 0.5) {
                    camGame.shake(FlxG.random.float(0.015, 0.02), FlxG.random.float(0.075, 0.125));
                } else{
                    camHUD.shake(FlxG.random.float(0.015, 0.02), FlxG.random.float(0.075, 0.125));
                }
            }
        if (health > 0.75) {
            health -= FlxG.random.float(0.075, 0.2);// glitch damage
        }
        for (i in 0...cpuStrums.length) {
            cpuStrums.members[i].x = defaultOppX[i] + FlxG.random.int(-8, 8);
            cpuStrums.members[i].y = 50 + FlxG.random.int(-8, 8);
        }
        if (!glitching){
            distorDad.binaryIntensity = 0;
            distorDad.negativity = 0;
        }
    }
} 
function update(elapsed:Float) {
    if (distorShit > 0) {// turn off the shader when it's not the type of note
        distorShit -= elapsed;
        if(distorShit <= 0) {
            distorShit = 0;
            
                if (dad.shader == distorDad)dad.shader = null;
            }
        }
}     