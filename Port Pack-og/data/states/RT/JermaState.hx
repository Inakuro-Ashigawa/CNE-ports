import legacy.StupidFuckingCursorDumb;
import openfl.display.BlendMode;
public var camTween:FlxTween;

public static var instance:JermaState;
public static var inSubMenu:Bool = false;
var introControlLock:Bool = true;

//camera and cursor stuff
var nextCamera:FlxCamera;
var cursorCamera:FlxCamera; //required due to zooms
public var animatedCursor:StupidFuckingCursorDumb;

//dialogue
var dialogueBox:FlxSprite;
var dialogueText:Alphabet = null;
var dialogueFinishJob:Void->Void = null;

//sprites
var staticOverlay:FlxSprite;
var jerma:FNFSprite;
var selectableGroup:Array<FNFSprite> = [];
var bejeweled:FlxSprite;
var davenald:FlxSprite;
var tvStatic:FlxSprite;
var curSelected:Int = -1;

//dw about this
final _realTMR:Float = 50;
var _imSorryTmr:Float = 0;

//secondtmr
final _daveTMRReset:Float = 10;
var _daveTMR:Float = 0;
static var seenDave:Bool = false;
static var eggXIsComing:Float = 0;

//tmr for when jerma will start saying stuff
final _TMR:Float = 20;
var _waitTmr:Float = 0;

//jerma dialogue stuff
var tags:Map<Int,String>;
var jermaDialogue = [
    'intro' => ['What can I do for ya?','idle'],
    'images' => ['Oh these? GREAT memories! Wish I was as lucky as they are, heh heh.','lookleft'],

    'tape' => ["Oh, you're a music man are ya? i'm something of a connoisseur of the arts myself. Here are some tunes I was able to record... Don't ask how I got em.",'point','false'],
    'book' => ["Ooh, trying to study up, are we?",'heh','false'],
    'tv' => ["i fucking love tvs AHAHAHAHAHHAHAHAHA",'laugh','false'],
    
    'wait1' => ["Out with it, kid! You're not the only one gettin blue balls here... ",'hmm'],
    'wait2' => ["I haven't got all day, mate. Ask me something, or get lost",'hmm'],
    'wait3' => ["Ohh, brother.",'hmm'],

    'bejeweled' => ['oh shit bejeweled jerma gif, oh fuck yeah','lookleft'],
    'davenald' => ['oh what the fuck what the fuck was that what was that, oh my god what was that','thereitisAgain'],
    'davenald1' => ['dude fuck there it is again what IS THAT!!!','thereitisAgain'],
    'pain' => ['LIFE IS PAIN I HATE','']
];

function create() {
    resetTmrs();

    persistentUpdate = true;

    instance = this;



    if (FlxG.sound.music != null) {
        FlxG.sound.music.fadeOut(0.4,0, Void -> {FlxG.sound.music.stop(); FlxG.sound.music = null;});
    }

    var bookshelf = new FlxSprite(855,-35).loadGraphic(Paths.image('RT Stuff/userinterface/jerma/bookshelf'));
    add(bookshelf);

    makeSelectable('tape',932,231,[16,17]);

    makeSelectable('book',926,45,[15.5,10.5]);

    var xLeftOffset:Float = -70;
    var tvOffsetY:Float = 20;
    var tvOffset:Float = 95;

    var cloudbg = new FlxSprite(168 + xLeftOffset,240 + tvOffsetY);
    cloudbg.makeGraphic(188, 131, 0xFF240000);
    add(cloudbg);

    var clouds = new FlxSprite(169 + xLeftOffset,246 + tvOffsetY);
    clouds.frames = Paths.getSparrowAtlas('RT Stuff/userinterface/jerma/cloude');
    clouds.animation.addByPrefix('i','cloudmov instance 1',24);
    clouds.animation.play('i');
    add(clouds);

    var tvcharacters = new FlxSprite(183 + xLeftOffset,256 + tvOffsetY);
    tvcharacters.frames = Paths.getSparrowAtlas('RT Stuff/userinterface/jerma/tvcharacters');
    tvcharacters.animation.addByPrefix('i','tkescreen instance 1',24);
    tvcharacters.animation.play('i');
    add(tvcharacters);
 
    bejeweled = new FlxSprite();
    bejeweled.frames = Paths.getSparrowAtlas('RT Stuff/userinterface/jerma/bejelewed');
    bejeweled.animation.addByPrefix('i','bejelewed i',20,true);
    bejeweled.setGraphicSize(cloudbg.width,cloudbg.height);
    bejeweled.setPosition(cloudbg.x,cloudbg.y);
    add(bejeweled);
    bejeweled.alpha = 0;

    davenald = new FlxSprite().loadGraphic(Paths.image('RT stuff/userinterface/jerma/davenald'));
    davenald.setGraphicSize(cloudbg.width,cloudbg.height);
    davenald.setPosition(cloudbg.x,cloudbg.y);
    add(davenald);
    davenald.alpha = 0;

    tvStatic = new FlxSprite();
    tvStatic.frames = Paths.getSparrowAtlas('static');
    tvStatic.animation.addByPrefix('i','static idle',24);
    tvStatic.animation.play('i');
    tvStatic.setGraphicSize(cloudbg.width,cloudbg.height);
    tvStatic.setPosition(cloudbg.x,cloudbg.y);
    add(tvStatic);
    tvStatic.alpha = 0.1;

    makeSelectable('tv',129 + xLeftOffset,137 + tvOffset + tvOffsetY,[-0.5,11.5 + tvOffset],0, -200);
    //selectableGroup[selectableGroup.length-1].addOffset('idle',0,tvOffset);

    var tvlight = new FlxSprite(100 + xLeftOffset,180 + tvOffsetY).loadGraphic(Paths.image('RT stuff/userinterface/jerma/TVLight'));
    add(tvlight);

    var tvshimmer = new FlxSprite(259 + xLeftOffset,249 + tvOffsetY).loadGraphic(Paths.image('RT stuff/userinterface/jerma/TVshimmer'));
    tvshimmer.alpha = 0.2;
    add(tvshimmer);

    var imgOffset:Float = -50;
    makeSelectable('images',143 + xLeftOffset + 25,-90 + imgOffset - 10 + tvOffsetY,[23.5,35.5 + imgOffset]);
    //selectableGroup[selectableGroup.length-1].addOffset('idle',0,imgOffset);

    if (FlxG.random.bool(0.00001 + eggXIsComing)) {
        var realimages = new FlxSprite(143 + xLeftOffset + 25 + 25,-90 - 10 + tvOffsetY + 25).loadGraphic(Paths.image('RT stuff/userinterface/jerma/realestimages'));
        add(realimages);
    }
    eggXIsComing += 0.00002;
    var tvcharacters = new FlxSprite(183 + xLeftOffset,256 + tvOffsetY);
    tvcharacters.frames = Paths.getSparrowAtlas('RT Stuff/userinterface/jerma/tvcharacters');
    tvcharacters.animation.addByPrefix('i','tkescreen instance 1',24);
    tvcharacters.animation.play('i');
    add(tvcharacters);

    jerma = new FlxSprite(-200,88);
    jerma.frames = Paths.getSparrowAtlas('RT stuff/userinterface/jerma/jerma');
    jerma.animation.addByPrefix('idle','jermaidle');
    jerma.animation.addByPrefix('laugh','laugh');
    jerma.animation.addByPrefix('hmm','jermahmm');
    jerma.animation.addByPrefix('point','jermastinkyfinger');
    jerma.animation.addByPrefix('heh','jermaheh');
    jerma.animation.addByPrefix('lookleft','jermaleft');
    jerma.animation.addByPrefix('what','huhwhat');
    jerma.animation.addByPrefix('thereitisAgain','thereitisagain');


    jerma.animation.play('idle');
    add(jerma);

    var painful = FlxG.random.bool(0.1);
    if (painful) {
        var painJerma = new FlxSprite(jerma.x,jerma.y-50).loadGraphic(Paths.image('RT stuff/userinterface/jerma/jermapain'));
        add(painJerma);
        jerma.visible = false;
   }


    var overlay = new FlxSprite(78).loadGraphic(Paths.image('RT stuff/userinterface/jerma/overlay'));
    add(overlay);
    overlay.scrollFactor.set();

    dialogueBox = new FlxSprite(0,jerma.y + jerma.height).loadGraphic(Paths.image('RT stuff/userinterface/jerma/jermaspeech'));
    dialogueBox.y += -dialogueBox.height + -180;
    //dialogueBox.centerOnSprite(jerma,X);
    add(dialogueBox);
    dialogueBox.visible = false;

    nextCamera = new FlxCamera();
    FlxG.cameras.add(nextCamera,false);

    cursorCamera = new FlxCamera();
    FlxG.cameras.add(cursorCamera,false);  //tbh we maybe shoudlve? idk made this a openfl sprite that is laid over the game

    animatedCursor = new StupidFuckingCursorDumb();

    animatedCursor.mouseLockon = true;

    staticOverlay = new FlxSprite();
    staticOverlay.frames = Paths.getSparrowAtlas('RT stuff/userinterface/jerma/jermstati');
    staticOverlay.animation.addByPrefix('i','jermstati i',16,true);
    staticOverlay.animation.play('i');
    staticOverlay.angle = 90;
    staticOverlay.setGraphicSize(0,FlxG.width*1.5);
    staticOverlay.screenCenter();
    staticOverlay.alpha = 0.0075;
    //staticOverlay.blend = "add";
    //add(staticOverlay);
    staticOverlay.cameras = [cursorCamera];

    add(animatedCursor);

    //FadeTransition.nextCamera = nextCamera;


    init(painful);
    



}

function init(painful:Bool = false) 
{
    FlxG.camera.scroll.set(-75,-300);
    FlxG.camera.zoom = 2;
    camLocked = true;
    lerpValue = 0;
    FlxTween.tween(FlxG.camera, {"scroll.y": -50,zoom: 1.1},2, {ease: FlxEase.cubeOut, onComplete: Void -> {
        camLocked = false;
        xx = -75;
        yy = -50;
        //FlxTween.tween(this, {lerpValue: 0.04},0.7);
        introControlLock = false;

        var dataPath = 'intro';
        if (painful) {
            dataPath = null; 
            (FlxG.sound.play(Paths.sound('jerma/' + dataPath))).onComplete = ()->{Sys.exit(0);};
        }

        var getdata = jermaDialogue.get(dataPath);
        startDialogue(getdata[0],getdata[1],dataPath);
        FlxG.cameras.remove(nextCamera);
    }});
}

inline function resetTmrs(resetthatTimer:Bool = true) {
    if (resetthatTimer) _imSorryTmr = _realTMR;
    
    _waitTmr = _TMR;
    _daveTMR = _daveTMRReset;
}

function triggerResponse(id:Int) { 

    var anim = tags.get(id); //gross but im lazy now
    var data = jermaDialogue.get(anim);

    switch (anim) {
        case 'book':
            dialogueFinishJob = () -> {
                camLocked = true;
                trace('hi');
                openSubState(new BookSubstate());
                jermaDialogue.get(anim)[2] = 'true';
            }
            
        case 'tape':
           // TapeSubstate.preloadSongs();
            dialogueFinishJob = () -> {
                camLocked = true;

                //canceltweensof wasnt workuing?
                camTween = FlxTween.tween(FlxG.camera,{zoom:1.25},0.25,{ease: FlxEase.sineInOut});
                FlxG.camera.fade(FlxColor.BLACK,0.25,false,()->{
                    FlxG.camera.fade(FlxColor.BLACK,0.25,true);
                    openSubState(new TapeSubstate());
                });
                jermaDialogue.get(anim)[2] = 'true';
            }
        case 'tv':
            dialogueFinishJob = () -> {
                camLocked = true;
                camTween = FlxTween.tween(FlxG.camera,{zoom:1.25},0.25,{ease: FlxEase.sineInOut});
                FlxG.camera.fade(FlxColor.BLACK,0.25,false,()->{
                    FlxG.camera.fade(FlxColor.BLACK,0.25,true);
                    openSubState(new GallerySubstate());
                });
                jermaDialogue.get(anim)[2] = 'true';

            }
        default:
            dialogueFinishJob = null;
    }
    FlxG.sound.play(Paths.sound('SEL_select'));

    if (data[2] != null && data[2] == 'true') {
        dialogueFinishJob();
        return;
    }
    startDialogue(data[0],data[1],anim);

    
}

//decided to add the mouse anim logic to this lol. Actually works pretty well too i think
function resetAnims(forced:Bool = false) {
    if (forced) {for (i in selectableGroup) i.animation.play('idle'); animatedCursor.mouseInterest = false; return;}

    var counter:Int = 0;
    for (i in selectableGroup) {
        if (!FlxG.mouse.overlaps(i)) {
            counter++;
        }
    }
    if (counter == selectableGroup.length) {
        curSelected = -1;
        for (i in selectableGroup) i.animation.play('idle');
        animatedCursor.mouseInterest = false;
    }
    else {
        animatedCursor.mouseInterest = true;
    }
}

function selectObject(ID:Int) {
    curSelected = ID;
    for (i in selectableGroup) {
        if (i.ID == ID) {
            i.animation.play('select',false);
        }
        else {
            i.animation.play('idle',true);
        }
    }
}


function startDialogue(dialogue:String,jermaAnim:String,?key:String,resetTimer:Bool = true) {
    if (_deletingDialogue) return;
     
    
    resetTmrs(resetTimer);
    camLocked = true;
    lerpValue = 0;

    FlxTween.tween(FlxG.camera,{'scroll.x': jerma.x + 150, "scroll.y": jerma.y - 100},1, {ease: FlxEase.circInOut, onComplete: Void -> {
        xx = FlxG.camera.scroll.x;
        yy = FlxG.camera.scroll.y;
    }});


    var wordLength:Float = dialogue.length;
    var wordScale = 0.6;
    var time:Float = 0.045;
    var isLongText:Bool = false;

    if (wordLength >= 100) {
        //maybe account for dialogue overlapping itself but i feel that like wont happen ever?
        wordScale = 0.45;
        isLongText = true;


    }


    

    if (key != null) {
            FlxG.sound.play(Paths.sound('jerma/' + key));
            var soundLength:Float = Paths.sound('jerma/'+ key).length;
            time = soundLength/wordLength;
            time /=1000;
            time *= 0.6;
            //trace(time);
            trace(wordLength);
        
        }


    jerma.animation.play(jermaAnim);
    dialogueBox.visible = true;
    dialogueText = new Alphabet(dialogueBox.x-40, dialogueBox.y + 40, dialogue, false,true,time,wordScale,true);
    if (isLongText) {
        dialogueText.verticalSpacing = 45;
    }

    add(dialogueText);

}

var _deletingDialogue:Bool = false;
function finishDialogue() {
    if (_deletingDialogue) return;
    _deletingDialogue = true;

    new FlxTimer().start(2, Void -> {
        inst.fadeTween.cancelTween();
        vocals.fadeTween.cancelTween();

        inst.fadeIn(1,inst.volume,0.7);
        vocals.fadeIn(1,vocals.volume,0.7);      

        if(dialogueText != null) {
            dialogueText.killTheTimer();
            dialogueText.kill();
            remove(dialogueText);
            dialogueText.destroy();
            dialogueText = null;
            _deletingDialogue = false; 
        }
        dialogueBox.visible = false;
        jerma.animation.play('idle');

        FlxTween.tween(this, {lerpValue: 0.04},0.7);
        if(dialogueFinishJob != null) dialogueFinishJob();
        else {camLocked = false;}
    });

}

var xx:Float = 0;
var yy:Float = 0;
var camLocked:Bool = false;
var lerpValue:Float = 0.04;
function camMovement() {
    if (camLocked) return;

    var yOffset:Float = -100;
    if (dialogueText != null && !dialogueText.finishedText || _deletingDialogue) yOffset = -50;
        
    var newX = ((FlxG.mouse.screenX - (FlxG.width/2)) / 15) - 75;
    var newY = ((FlxG.mouse.screenY - (FlxG.height/2)) / 15) + yOffset;

    xx = lerp(xx, newX,lerpValue);
    yy = lerp(yy, newY,lerpValue);

    FlxG.camera.scroll.x = xx;
    FlxG.camera.scroll.y = yy;
    //if (!introControlLock) {
        FlxG.camera.zoom = lerp(FlxG.camera.zoom,1.1,0.1);
    //}
}

function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		offsets[name] = [x, y];
	}

function makeSelectable(name:String,x:Float,y:Float,offsets:Array<Float>,widthAdd:Float = 0,heightAdd:Float = 0) 
{

    var i:FlxSprite = new FlxSprite(x,y);
    i.frames = Paths.getSparrowAtlas('RT Stuff/userinterface/jerma/'+ name);
    i.animation.addByPrefix('idle','i');
    i.animation.addByPrefix('select','select', 24);
    i.animation.play('idle');
    i.setPosition(offsets[0],offsets[1]);
    add(i);
    i.ID = selectableGroup.length;
    selectableGroup.push(i);
    i.width = i.frameWidth + widthAdd;
    i.height = i.frameHeight + heightAdd;
}
function update(elapsed:Float) {

        tvStatic.alpha = 0;
        if (_imSorryTmr < 0) {
            resetTmrs();
            tvStatic.alpha = 1;
            bejeweled.alpha = 1;
            bejeweled.animation.play('i');
            //var getdata = jermaDialogue.get('bejeweled');
            //startDialogue(getdata[0],getdata[1],'bejeweled');
            //dialogueFinishJob = ()->{camLocked = false;tvStatic.alpha = 1; bejeweled.alpha = 0;}
        }
        //if (tvStatic.alpha != 0) {tvStatic.alpha = lerp(tvStatic.alpha,0,0.2);}


        camMovement();

        if (controls.BACK && !introControlLock) {
            FlxG.sound.play(Paths.sound('SEL_back'));
            FlxG.switchState(new ModState("RT/DesktopMenuState"));
        }


        if (dialogueText != null) {
            if (dialogueText.finishedText && !_deletingDialogue) {
                finishDialogue();
            }
        }

        var forceAnimReset = true;
        if (dialogueText == null && !introControlLock) {
            forceAnimReset = false;
            for (i in selectableGroup) {
                var current:Bool = (i.ID == curSelected);
                if (FlxG.mouse.overlaps(i)) {
                    if (!current) selectObject(i.ID);
                    if (FlxG.mouse.justPressed) {
                        triggerResponse(i.ID);
                    }
                }
            }
        }
        resetAnims(forceAnimReset);

        if (FlxG.mouse.x >=1047 && FlxG.mouse.x <= 1140 && FlxG.mouse.y >=357 && FlxG.mouse.y <= 438 && FlxG.mouse.justPressed) FlxG.sound.play(Paths.sound('jerma/squish'));

    }
