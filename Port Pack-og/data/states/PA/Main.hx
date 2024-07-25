import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import flixel.input.mouse.FlxMouseEvent;
import funkin.menus.credits.CreditsMain;
import funkin.options.OptionsMenu;
import funkin.editors.EditorPicker;
import funkin.menus.ModSwitchMenu;
import openfl.Lib;

var pibbyFNF = new CustomShader('Pibbified');
var VCR = new CustomShader('OldTVShader');
var psychEngineVersion:String = '0.6.2'; // This is also used for Discord RPC
var curSelected:Int = 0;

var cinematicdown:FlxSprite;
var cinematicup:FlxSprite;

var menuItems:FlxTypedGroup<AlphabetTyped>;


var pibbyFNF = new CustomShader('Pibbified');
var VCR = new CustomShader('OldTVShader');

var shaderIntensity:Float;

var optionShit:Array<String> = ['FREEPLAY', 'CREDITS'];

var magenta:FlxSprite;
var camFollow:FlxObject;
var camFollowPos:FlxObject;
var debugKeys:Array<FlxKey>;
var aweTxt:FlxText;
var verTxt:FlxText;
var barTab:FlxSprite;

var URL:String = "https://pastebin.com/raw/HLtJfzAC";
var MOTD:String;

var options:FlxSprite;
var discord:FlxSprite;

var freeplayhitbox:FlxSprite;
var creditshitbox:FlxSprite;
function create(){
    window.title = "Pibby: Apocalypse - Main Menu";
    freeplayhitbox = new FlxSprite(160, 30).makeGraphic(374, 59, FlxColor.GREEN);
    freeplayhitbox.alpha = 1;
    add(freeplayhitbox);

    creditshitbox = new FlxSprite(740, 30).makeGraphic(374, 59, FlxColor.GREEN);
    creditshitbox.alpha = 1;
    add(creditshitbox);

    var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
    var bg:FlxSprite = new FlxSprite(0, -10).loadGraphic(Paths.image('pibymenu/BACKGROUND'));
    bg.scrollFactor.set(0, 0);
    bg.setGraphicSize(Std.int(bg.width * 0.8));
    bg.updateHitbox();
    bg.screenCenter(FlxAxes.X);
    bg.antialiasing = Options.Antialiasing;
    bg.shader = VCR;
    add(bg);

    camFollow = new FlxObject(0, 0, 1, 1);
    camFollowPos = new FlxObject(0, 0, 1, 1);
    add(camFollow);
    add(camFollowPos);

    magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
    magenta.scrollFactor.set(0, yScroll);
    magenta.setGraphicSize(Std.int(magenta.width * 1.175));
    magenta.updateHitbox();
    magenta.screenCenter();
    magenta.visible = false;
    magenta.antialiasing = Options.Antialiasing;
    magenta.color = 0xFFfd719b;
    add(magenta);

    // magenta.scrollFactor.set();

    cinematicdown = new FlxSprite().makeGraphic(FlxG.width, 70, FlxColor.BLACK);
    cinematicdown.scrollFactor.set();
    cinematicdown.setPosition(0, FlxG.height - 70);
    cinematicdown.antialiasing = Options.Antialiasing;
    add(cinematicdown);

    cinematicup = new FlxSprite().makeGraphic(FlxG.width, 100, FlxColor.BLACK);
    cinematicup.scrollFactor.set();
    cinematicup.antialiasing = Options.Antialiasing;
    add(cinematicup);

    options = new FlxSprite().loadGraphic(Paths.image('pibymenu/Options'));
    options.alpha = 0.4;
    options.scale.set(0.3, 0.3);
    options.updateHitbox();
    options.setPosition(FlxG.width - 97, FlxG.height - 63);
    options.antialiasing = Options.Antialiasing;
    add(options);

    discord = new FlxSprite().loadGraphic(Paths.image('pibymenu/discord'));

    discord.alpha = 0.4;
    discord.scale.set(0.3, 0.3);
    discord.updateHitbox();
    discord.setPosition(options.x - 85, FlxG.height - 60);
    discord.antialiasing = Options.Antialiasing;
    add(discord);

    menuItems = new FlxTypedGroup();
    add(menuItems);
    for (i in 0...optionShit.length)
    {
        var menuItem:Alphabet = new Alphabet(0, 60 + (i * 160), optionShit[i]);
        menuItem.alpha = 0.4;
        menuItem.ID = i;
        switch (optionShit[i])
        {
            case 'CREDITS':
                menuItem.x = 795;
                menuItem.y = -75;
            case 'FREEPLAY':
                menuItem.y = -75;
                menuItem.x = 170;
        }
        menuItems.add(menuItem);
        var scr:Float = (optionShit.length - 4) * 0.135;
        if (optionShit.length < 6)
            scr = 0;
        menuItem.scrollFactor.set(0, scr);
        menuItem.antialiasing = Options.Antialiasing;
        // menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
        menuItem.updateHitbox();
        menuItem.x -= 125;
    }
}
var dumbstupid:Float = 0;
function update(elapsed:Float)
{
dumbstupid += elapsed;
VCR.iTime = dumbstupid;


if (FlxG.mouse.justPressed & FlxG.mouse.overlaps(options))
    {
        FlxTween.tween(options, {alpha: 1}, 0.25, {
            ease: FlxEase.quadOut,
            onComplete: function(twn:FlxTween)
            {
                twn.cancel(); // idk if this is necessary (idk how to write necessary sdfashdjfhdjhajdfhaskdhfalkdhfkj)
                FlxG.switchState(new OptionsMenu());
            }
        });
    }

    if (FlxG.mouse.justPressed & FlxG.mouse.overlaps(discord))
    {
        FlxTween.tween(discord, {alpha: 1}, 0.25, {
            ease: FlxEase.quadOut,
            onComplete: function(twn:FlxTween)
            {
                twn.cancel(); // idk if this is necessary (idk how to write necessary sdfashdjfhdjhajdfhaskdhfalkdhfkj)
                FlxG.openURL('https://discord.gg/yPKffqXtJd');
            }
        });
    }
    if (FlxG.random.int(0, 1) < 0.01)
    {
        shaderIntensity = FlxG.random.float(0.2, 0.3);
    }

    if (controls.LEFT_P)
    {
        FlxG.sound.play(Paths.sound('scrollMenu'));
        changeItem(-1);
    }

    if (controls.RIGHT_P)
    {
        FlxG.sound.play(Paths.sound('scrollMenu'));
        changeItem(1);
    }

    if (controls.BACK)
    {
        selectedSomethin = true;
        FlxG.sound.play(Paths.sound('cancelMenu'));
        if (!FlxG.save.data.PAmenus) FlxG.switchState(new TitleState());
        if (FlxG.save.data.PAmenus) FlxG.switchState(new ModState("PA/Title"));
    }
    if (FlxG.keys.justPressed.SEVEN) openSubState(new EditorPicker());

    if (controls.SWITCHMOD) {
        openSubState(new ModSwitchMenu());
        persistentUpdate = false;
        persistentDraw = true;
    }
    if (controls.ACCEPT)
    {
        selectedSomethin = true;
        FlxG.sound.play(Paths.sound('confirmMenu'));

        menuItems.forEach(function(spr:FlxSprite)
        {
            if (curSelected != spr.ID)
            {
                FlxTween.tween(spr, {alpha: 0}, 0.4, {
                    ease: FlxEase.quadOut,
                    onComplete: function(twn:FlxTween)
                    {
                        spr.kill();
                    }
                });
            }
            else
            {
                FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
                {
                    var daChoice:String = optionShit[curSelected];

                    switch (daChoice)
                    {
                        case 'FREEPLAY':
                            if (FlxG.save.data.PAmenus)  FlxG.switchState(new ModState("PA/freeplay"));
                            if (!FlxG.save.data.PAmenus) FlxG.switchState(new FreeplayState());
                            FlxG.sound.playMusic(Paths.music('fpmenu'));
                        case 'CREDITS':
                            //credits aint done i just did this to make testing easier
                            LoadingState.loadAndSwitchState(new PACreditsState());
                            FlxG.sound.playMusic(Paths.music('creditsmenu'));

                            //Lib.getURL(new URLRequest('https://gamebanana.com/wips/73842'));
                            //MusicBeatState.switchState(this);
                    }
                });
            }
        });
    }
}
function selectThing()
{
    selectedSomethin = true;
    FlxG.sound.play(Paths.sound('confirmMenu'));

    menuItems.forEach(function(spr:FlxSprite)
    {
        if (curSelected != spr.ID)
        {
            FlxTween.tween(spr, {alpha: 0}, 0.4, {
                ease: FlxEase.quadOut,
                onComplete: function(twn:FlxTween)
                {
                    spr.kill();
                }
            });
        }
        else
        {
            FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
            {
                var daChoice:String = optionShit[curSelected];

                switch (daChoice)
                {
                    case 'STORY MODE':
                        MusicBeatState.switchState(new StoryMenuState());
                    case 'FREEPLAY':
                        MusicBeatState.switchState(new FreeplayState());
                        FlxG.sound.playMusic(Paths.music('fpmenu'));
                    case 'CREDITS':
                        LoadingState.loadAndSwitchState(new PACreditsState());
                        FlxG.sound.playMusic(Paths.music('creditsmenu'));
                }
            });
        }
    });
}

function changeItem(huh:Int = 0)
{
curSelected += huh;

if (curSelected >= menuItems.length)
    curSelected = 0;
if (curSelected < 0)
    curSelected = menuItems.length - 1;

// If the bar exists we destroy it to save memory
if (barTab != null)
    barTab.destroy();

// A bunch of math shit to make bar under the text lolll --Aaron
barTab = new FlxSprite().makeGraphic(Std.int(menuItems.members[curSelected]) + 400, 5, FlxColor.WHITE);
barTab.setPosition(menuItems.members[curSelected].x + (menuItems.members[curSelected] / 2) + 90,
    menuItems.members[curSelected].y + 160);
barTab.antialiasing = Options.Antialiasing;
add(barTab);

menuItems.forEach(function(spr:FlxSprite)
{
    spr.alpha = 0.4;
    spr.updateHitbox();

    if (spr.ID == curSelected)
    {
        FlxTween.tween(spr, {alpha: 1}, 0.1, {
            ease: FlxEase.quadInOut,
            onComplete: function(twn:FlxTween)
            {
                spr.alpha = 1;
            }
        });
    }
});
}

