// for noteType stuff
// NO TOUCHIES MAFAKA >:(
import StringTools;
public var singDir = ["LEFT", "DOWN", "UP", "RIGHT"];
public var glitches = new CustomShader("NewGlitch2");
public var distorDad:CustomShader;
var aberration = new CustomShader('chromaticAberration');
var bloom = new CustomShader('bloom');// bloom shader
public var defaultOppX = [];
public var defaultPlayX = [];
var data:Map<Int, {lastNote:{time:Float, id:Int}}> = [];
static var disableDoubles:Bool = false;// disabling double notes (will make the option later)


function create() {
distorDad = new CustomShader("distortShader");	
dad.shader == distorDad;
}
function postCreate(){
        for (i in cpuStrums.members){
            i.shader = glitches;
       
    }
    

        setGeneralIntensity(0.001);
        camGame.addShader(aberration);
        camHUD.addShader(aberration);
        camGame.addShader(bloom);
        bloom.size = 0.0;
   
    
    // to get the number of each positions of the strums member
    for (i in cpuStrums.members) {defaultOppX.push(i.x);}
    for (i in playerStrums.members) {defaultPlayX.push(i.x);}

    // don't delete this if you want to make the double nte glitch same to [var data:Map<Int, {lastNote:{time:Float, id:Int}}> = [];]
	for (sl in strumLines.members){
		data[strumLines.members.indexOf(sl)] = {
            lastNote: {
                time: -9999,
                id: -1
            }
        };
    }
}

var intens:Float = 0;
function setGeneralIntensity(val:Float) {
	intens = val;
	aberration.redOff = [intens, 0];
	aberration.blueOff = [-intens, 0];
}

var canBump:Bool = camZooming;
function aberrationCoolThing() {
	canBump = !canBump;
	if(!canBump) {
		setGeneralIntensity(0.001);  // Just to make sure if anything goes wrong
		maxCamZoom = 1.35;
	} else maxCamZoom = 0;
}

function stepHit(curStep:Int){
        var distortIntensity:Float = FlxG.random.float(4, 6);
        glitches.binaryIntensity = distortIntensity;
}

function beatHit(curBeat:Float) {
	if(camZooming && curBeat % camZoomingInterval == 0) {
		setGeneralIntensity(0.01);
	}
}

// lmao it's glitching time >:)
var glitch_time:Float;
public var distorShit:Float = 0;
function update(elapsed:Float) {
	if(Options.gameplayShaders && camZooming && intens > (0.0005)) setGeneralIntensity(intens - (0.001));// chrom abb thingy

    // icon glitching (more icons are in [data/scripts/])
    if (healthBar.percent < 20){
        if (Options.gameplayShaders) iconP1.shader = glitches;
    } else {
        iconP1.shader = null;
    }
    if (healthBar.percent > 80){
        if (Options.gameplayShaders) iconP2.shader = glitches;
    } else {
        iconP2.shader = null;
    }

    if (distorShit > 0) {// turn off the shader when it's not the type of note
        distorShit -= elapsed;
        if(distorShit <= 0) {
            distorShit = 0;
            
            // all characters that are inside dad strum will glitched
            for (dads in strumLines.members[0].characters){
                if (dads.shader == distorDad)dads.shader = null;
            }

            // to prevent error without add more shits
            if (strumLines.members[3] != null && strumLines.members[3].characters[0].shader == distorDad)
                strumLines.members[3].characters[0].shader = null;
        }
    }
}

// this is interesting..
// also inakuro if you want to use it just becarefull

function onDadHit(note:NoteHitnote){

    var curNotes = note.noteType;
    
    var glitching:Bool = false;

    // for double note glitch or shaking..
    // whatever
    var target = data[strumLines.members.indexOf(note.note.strumLine)];
    var doShits = (note.note.strumTime - target.lastNote.time) <= 2 && note.note.noteData != target.lastNote.id;
    target.lastNote.time = note.note.strumTime;
    target.lastNote.id = note.note.noteData;
    switch(dad.curCharacter) {
        case "dad", "gumball", "cumball", "finn-R", "jake", "finn-slash", "finn-sword", "finn-sword-shad", "finncawm", 
            "finncawm_reveal", "finncawm_start_new", "finnfalse", "badfinn", "finnanimstuff", "finn-hurt", "steven":
            if(doShits && !disableDoubles){
                if (note.note.isSustainNote) return;
                    if (FlxG.random.float(0, 1) < 0.5) {
                        camGame.shake(FlxG.random.float(0.015, 0.02), FlxG.random.float(0.075, 0.125));
                    } else {
                        camHUD.shake(FlxG.random.float(0.015, 0.02), FlxG.random.float(0.075, 0.125));
                        for (i in 0...cpuStrums.length) {
                            cpuStrums.members[i].x = defaultOppX[i] + FlxG.random.int(-8, 8);
                            cpuStrums.members[i].y = 50 + FlxG.random.int(-8, 8);
                        }
                        if (boyfriend.curCharacter == "darwin-fw"){
                            for (i in 0...playerStrums.length) {
                                playerStrums.members[i].x = defaultPlayX[i] + FlxG.random.int(-8, 8);
                                playerStrums.members[i].y = 50 + FlxG.random.int(-8, 8);
                            }
                        }
                    }
                if (health > 0.75) {
                    health -= FlxG.random.float(0.075, 0.2);// glitch damage
                }
            }
    }

    if (curNotes == "Glitch Note" || curNotes == "Both Char Glitch"){// make the opponent glitching
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
    }

    if (curNotes == "Second Char Sing" || curNotes == "Second Char Glitch"){// second opponen char singing
        note.characters = strumLines.members[3].characters;
    }

    if (curNotes == "Second Char Glitch"){// make the second opponent glitching
        distorShit = 0.125;
        glitching = !glitching;
        if (Options.gameplayShaders){
            if (!note.note.isSustainNote){
            distorDad.binaryIntensity = FlxG.random.float(-1, -0.5);

            // this is mainly for SS
            if (strumLines.members[3].characters[0].shader == null)strumLines.members[3].characters[0].shader = distorDad;
                distorDad.negativity = (note.sustainLength > 0 ? note.sustainLength/1000 : 0) + FlxG.random.float(1.0, 2.0);
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
    }

    if (!glitching){
        distorDad.binaryIntensity = 0;
        distorDad.negativity = 0;
    }
}
function onNoteCreation(e)// to make it more sense because.. it's glitch note types..?
    if (Options.gameplayShaders){
        if (e.noteType == "Glitch Note" || e.noteType == "Second Char Glitch" || e.noteType == "Both Char Glitch") e.note.shader = glitches;
   }

function onNoteHit(note){

    var curNotes = note.noteType;

    //if (!PlayState.opponentMode) {

    switch(curNotes) {
            
    case "Second Char Sing":
        strumLines.members[3].characters[0].playAnim("sing" + singDir[note.direction], true);
        note.cancelAnim();

    if (curNotes == "No Anim Note" || curNotes == "No Animation"){
        note.cancelAnim();
        trace("HI :]");
    }
  }
}

function onPlayerHit(note:NoteHitEvent) {
    if (PlayState.opponentMode){
    if (note.note.prevNote == null || note.note.isSustainNote) return;
    if (note.note.prevNote.noteData == note.note.noteData) return;
    if (note.note.prevNote.mustPress == note.note.mustPress && note.note.prevNote.strumTime == note.note.strumTime){
    //if (note.note.strumTime == note.note.prevNote.strumTime) {
        camera.shake(0.04, 0.02);
        camHUD.shake(0.04, 0.1);
        shakes();
    }}
}
function onDadHit(note:NoteHitEvent) {
    if (!PlayState.opponentMode){
    if (note.note.prevNote == null || note.note.isSustainNote) return;
    if (note.note.prevNote.noteData == note.note.noteData) return;
    if (note.note.prevNote.mustPress == note.note.mustPress && note.note.prevNote.strumTime == note.note.strumTime){
    //if (note.note.strumTime == note.note.prevNote.strumTime) {
        camera.shake(0.04, 0.02);
        camHUD.shake(0.04, 0.1);
        shakes();
    }}
}
