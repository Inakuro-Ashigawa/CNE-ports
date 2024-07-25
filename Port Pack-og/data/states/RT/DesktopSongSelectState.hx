import flixel.tweens.FlxEase;
import flixel.math.FlxMath;
import flixel.tweens.FlxTween;
import funkin.backend.MusicBeatState;
import flixel.text.FlxText;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxTimer;
import funkin.backend.utils.CoolUtil;
import legacy.StupidFuckingCursorDumb;

    var songList:Array<Dynamic> = [ 
        // ['Song Name', [X, Y], [Offset X, Offset Y]], [Banner Ofs X, Banner Ofs, Y]]
        ['2torial',[25.8,481.8], [-0.25, 0.1125], [-14, 0]],
        ['obituary',[100.45,464.25], [-0.475, 0.225], [-10.75, -19.75]]
    ];
    var freePlayList:Array<String> = ["2torial", "obituary"];
    var curSelected:Int = 0;
    var difficulty:Int = 0; //0 easy, 1 normal, 2 hard

    var staticEffect:FlxSprite;

    var selectableSongs:FlxSpriteGroup = new FlxSpriteGroup();
    var banner:FlxSprite;
    var mouseHitbox:FlxSprite;
    var monitor:FlxSprite;
    
    var display:FlxCamera;
    var camCRT:FlxCamera;
    var camMouse:FlxCamera;

    var choosingDiff:Bool = false;

    var diffBG:FlxSprite;
    var diffOptions:FlxSpriteGroup = new FlxSpriteGroup();



    var curSelectedIcon:FlxSprite;
    var bf:FlxSprite;

    static public var fromFreeplay:Bool;
    var canSelect:Bool = false;
    
    final displayXoffset:Float = 205;

    var newCursor:StupidFuckingCursorDumb;

function create() {


        display = new FlxCamera();
        display.zoom = 0.75;
        FlxG.cameras.add(display,false);
        display.antialiasing = true;
    
        camCRT = new FlxCamera();
        camCRT.bgColor = 0;
        FlxG.cameras.add(camCRT,false);

        camMouse = new FlxCamera();
        camMouse.bgColor = 0;
        camMouse.zoom = 0.75;
        FlxG.cameras.add(camMouse,false);

        staticEffect = new FlxSprite();
        staticEffect.frames = Paths.getSparrowAtlas('RT stuff/static');
        staticEffect.animation.addByPrefix('i','static idle',24);
        staticEffect.animation.play('i');


        staticEffect.cameras = [camCRT];
        add(staticEffect);
        staticEffect.alpha = 0;

        monitor = new FlxSprite(199.9, -26.6);
        monitor.frames = Paths.getSparrowAtlas('RT stuff/userinterface/desktop/bgLayers');
        monitor.animation.addByPrefix("on", "monitorOn", 12, true);
        monitor.animation.play("on");
        monitor.updateHitbox();
        monitor.cameras = [camCRT];
        // monitor.alpha = 0.4;
        add(monitor);

        staticEffect.setGraphicSize(monitor.width-180,monitor.height - 350);
        staticEffect.setPosition(monitor.x - 360,monitor.y - 180);

        var gradient = new FlxSprite(3.7 + displayXoffset, 420.5).loadGraphic(Paths.image('RT stuff/userinterface/desktop/songMenu/gradient'));
        gradient.cameras = [display];
        add(gradient);
    
        var blank = new FlxSprite(85.9 + displayXoffset, 435.1).loadGraphic(Paths.image('RT stuff/userinterface/desktop/songMenu/blank'));
        blank.cameras = [display];
        add(blank);
    
        banner = new FlxSprite(-11.35 + displayXoffset,-20.7);
        banner.frames = Paths.getSparrowAtlas('RT stuff/userinterface/desktop/songMenu/banners');
        banner.cameras = [display];
        add(banner);
    
        selectableSongs.cameras = [display];
        add(selectableSongs);
    
        for (i in 0...songList.length) { //also later we use the uhhh unlocked songs to go filter out
            var sprite = new FlxSprite(songList[i][1][0] + displayXoffset,songList[i][1][1]);
            sprite.frames = Paths.getSparrowAtlas('RT stuff/userinterface/desktop/songMenu/icons/' + songList[i][0]);
            sprite.animation.addByPrefix('idle','Loop',24);
            sprite.animation.addByPrefix('hover','Selection0',24,false);
            sprite.animation.addByPrefix('selected','Confirm',24,false);
            sprite.animation.addByPrefix('hover-loop','SelectionLoop',24);
            sprite.animation.play('idle');
            sprite.updateHitbox();
            sprite.width = sprite.width/2;
            sprite.x += sprite.width/2;
            sprite.cameras = [display];
            sprite.ID = i;
            sprite.animation.finishCallback = (n:String) -> {
                switch (n) {
                    case 'hover':
                        sprite.animation.play('hover-loop');
                        sprite.offset.x = (sprite.offset.x + songList[i][2][0]);
                        sprite.offset.y = (sprite.offset.y + songList[i][2][1]);

                }
            }
            selectableSongs.add(sprite);
    
            banner.animation.addByPrefix(songList[i][0],songList[i][0],24);
            banner.animation.play(songList[i][0]);
    
        }

        bf = new FlxSprite(385.35 + displayXoffset,435.3);
        bf.frames = Paths.getSparrowAtlas('RT stuff/userinterface/desktop/songMenu/bf');
        bf.animation.addByPrefix("up", "up", 0);
        bf.animation.addByPrefix("down", "down", 0);
        bf.animation.addByPrefix("idle", "idle", 0);
        bf.animation.play("idle");
        bf.cameras = [display];
        bf.updateHitbox();
        bf.antialiasing = true;
        add(bf);

        mouseHitbox = new FlxSprite(0,0);
        mouseHitbox.makeGraphic(12, 12, 0xFFFF0000);
        mouseHitbox.visible = false;
        mouseHitbox.cameras = [camMouse];
        mouseHitbox.scrollFactor;
        add(mouseHitbox);

        newCursor = new StupidFuckingCursorDumb(0,0);
        newCursor.mouseLockon = false;
        add(newCursor); 

        display.alpha = 0;
        new FlxTimer().start(1, function(start:FlxTimer){
            canSelect = true;
            display.alpha = 1;
            staticEffect.alpha = .1;
        });

    }
    
 function update(elapsed:Float) {
        if (controls.BACK && !choosingDiff) {
            display.alpha = 0;
            new FlxTimer().start(1.7, function(start:FlxTimer){
               MusicBeatState.skipTransIn = MusicBeatState.skipTransOut = true;
                FlxG.switchState(new ModState("RT/DesktopMenuState"));

            });
        }

        if (staticEffect.alpha != 0) {
            staticEffect.alpha = lerp(staticEffect.alpha,0,0.1);
        }

        mouseHitbox.setPosition(((FlxG.mouse.x/display.zoom) - 418 )+ displayXoffset/*💀💀*/, (FlxG.mouse.y/display.zoom)- 122);

        // mouseHitbox.setPosition((FlxG.mouse.x/camMouse.zoom) - 418, (FlxG.mouse.y/camMouse.zoom)- 130);

        songSelectStuff();
        if (choosingDiff) diffSelectStuff();

        newCursor.setPosition(mouseHitbox.x, mouseHitbox.y);

        newCursor.mouseWaiting = !canSelect;
    
    }

    function bfLook(){
        var up:Bool = true;
        if (mouseHitbox.y >= 581) up = false;
        var animLength = up ? 9 : 6;
        bf.animation.play(up ? 'up' : 'down', true, false, Math.floor(FlxMath.bound(FlxMath.remapToRange(mouseHitbox.x,0,882,0,animLength),0,animLength)));
    }


    function diffSelectStuff() {
        //insert stuff here
        if (controls.BACK || !canSelect) {
            choosingDiff = false;
            diffBG.animation.play("close", true);
            remove(diffOptions);
            //hide otehr buttons
        }

        for (i in diffOptions) {
            if (mouseHitbox.overlaps(i,display)) {
                difficulty = i.ID;
                trace(difficulty);
                i.animation.play("hover");
                if (FlxG.mouse.justPressed) {
                    loadSong(curSelected, curSelectedIcon);
                    i.animation.play("flash", true);
                }
            }else i.animation.play("idle");
        }

        if (mouseHitbox.overlaps(diffOptions,display))newCursor.mouseInterest = true;
        else newCursor.mouseInterest=false;

        diffBG.centerOffsets();
    }

    function songSelectStuff() {


        if (!choosingDiff && canSelect) {
            newCursor.mouseInterest = mouseHitbox.overlaps(selectableSongs,display) ? true : false; 
        }

        for (i in selectableSongs) {
            if (!choosingDiff && canSelect){
                if (mouseHitbox.overlaps(i, display)) {
                    curSelected = i.ID;
                    if (!StringTools.contains(i.animation.curAnim.name, 'hover')) {FlxG.sound.play(Paths.sound('SEL_misc2'));i.animation.play('hover');}
                    if (FlxG.mouse.justPressed) {
                        // loadSong(curSelected, i);
                        curSelectedIcon = i;
                        spawnDiffSelector();
                    }
                } else {
                    i.animation.play('idle');
                }
                bfLook();
            }
            // i.updateHitbox();
            if(i.animation.curAnim.name != 'hover-loop') i.centerOffsets(); //need to fix em anyway
        }

        banner.animation.play(songList[curSelected][0]);
        banner.x = songList[curSelected][3][0] + displayXoffset;
        banner.y = songList[curSelected][3][1];

    }





     function spawnDiffSelector() {
        choosingDiff = true;

        diffBG = new FlxSprite(83.35 + displayXoffset,194.65);
        diffBG.frames = Paths.getSparrowAtlas('RT stuff/userinterface/desktop/songMenu/deezficulties');
        diffBG.animation.addByPrefix("open", "diffBGopen", 24, false);
        diffBG.animation.addByIndices("close", "diffBGopen", [6,5,4,3,2,1,0],"", 24, false);
        diffBG.animation.addByPrefix("loop", "diffBGloop", 6, true);
        diffBG.animation.play("open");
        diffBG.cameras = [display];
        diffBG.updateHitbox();
        diffBG.antialiasing = true;
        diffBG.animation.finishCallback = (g:String) -> {
            switch (g){
                case "open": 
                    diffBG.animation.play("loop");
                    diffOptions.visible = true;
                    trace('yahoo!');

                case "close": diffBG.alpha = 0; diffBG.visible = false; remove(diffBG);
                //DIIIIIEEEEEEEE DIE DIE DIE DIE DIEEE FUCK YOUUU FYCCCKKY YYIOUOOUUUUU FCYCJJKKK UOUUUUUUUDDDEIEEEEE
            }
        }


        var dgx:Float = 83.35;
        var dgy:Float = 194.65;
        var offsets:Array<Array<Float>> = [
            [59.55,58.8],
            [264.5,58.7],
            [475.8,58.1]
        ];

        for (i in 0...offsets.length) {
            var curDiff:String = 'easy';
            if (i == 1) curDiff = 'medium';
            if (i == 2) curDiff = 'hard';
            var diff = new FlxSprite(dgx + offsets[i][0] + displayXoffset,dgy + offsets[i][1]);
            diff.frames = Paths.getSparrowAtlas('RT stuff/userinterface/desktop/songMenu/deezficulties');
            diff.animation.addByIndices("idle", curDiff, [0,1,2], "", 6, true);
            diff.animation.addByIndices("hover", curDiff, [3,4,5], "", 6, true);
            diff.animation.addByIndices("flash", curDiff, [6,7], "", 30, true);
            diff.animation.play("idle");
            diff.updateHitbox();
            diff.antialiasing = true;
            diff.ID = i;
            diffOptions.add(diff);
        }
        diffOptions.cameras = [display];
  
        for (i in [diffBG, diffOptions]) insert(members.indexOf(mouseHitbox), i);
        diffOptions.visible = false;


    }
 function loadSong(curSelected:Int, anim:FlxSprite) {
        anim.animation.play('selected');
        FlxG.sound.play(Paths.sound('SEL_select'));
        FlxG.sound.play(Paths.sound('menu_select/'+ songList[curSelected][0]));
    
        new FlxTimer().start(3, function(FlxTimer)
            {                  
                camCRT.fade(0xFF000000, 1);
                MusicBeatState.skipTransIn = MusicBeatState.skipTransOut = true;
                PlayState.loadSong(songList[curSelected][0], "hard", false, false);
                FlxG.switchState(new PlayState());
            });
    }
