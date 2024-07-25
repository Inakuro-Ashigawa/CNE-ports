import flixel.ui.FlxBar;
import openfl.geom.Rectangle;
import flixel.util.FlxColor;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import flixel.ui.FlxBar;
import flixel.FlxG;

var boyfriendColor:FlxColor;
var pibbyColor:FlxColor;
var timeBarBG:FlxSprite;
var timeBar:FlxBar;
var timeTxt:FlxText;
var hudTxt:FlxText;
var hudTxtTween:FlxTween;
var ratingFC:String = "FC";
var ratingStuff:Array<Dynamic> = [
    ['You Suck!', 0.2], //From 0% to 19%
    ['Shit', 0.4], //From 20% to 39%
    ['Bad', 0.5], //From 40% to 49%
    ['Bruh', 0.6], //From 50% to 59%
    ['Meh', 0.69], //From 60% to 68%
    ['Nice', 0.7], //69%
    ['Good', 0.8], //From 70% to 79%
    ['Great', 0.9], //From 80% to 89%
    ['Sick!', 1], //From 90% to 99%
    ['Perfect!!', 1] //The value on this one isn't used actually, since Perfect is always "1"
];
function postCreate(){
for (i in [missesTxt, accuracyTxt, scoreTxt]) {
    i.visible = false;
 }

add(hudTxt);
}
function create(){
boyfriendColor = 0x78C2E2;
pibbyColor = 0xff69b4;

hudTxt = new FlxText(0, 685, FlxG.width, "Score: 0 | Misses: 0 | Rating: ?");
hudTxt.setFormat(Paths.font("vcr.ttf"), 20, boyfriendColor, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
hudTxt.borderSize = 1.25;
hudTxt.screenCenter(FlxAxes.X);


hudTxt.cameras = [camHUD];

}
function getRating(accuracy:Float):String {
    if (accuracy < 0) {
        return "?";
    }
    for (rating in ratingStuff) {
        if (accuracy < rating[1]) {
            return rating[0];
        }
    }
    return ratingStuff[ratingStuff.length - 1][0];
}

function getRatingFC(accuracy:Float, misses:Int):String {
    // this sucks but idk how to make it better lol
    if (misses == 0) {
        if (accuracy == 1.0) ratingFC = "SFC";
        else if (accuracy >= 0.99) ratingFC = "GFC";
        else ratingFC = "FC";
    }
    if (misses > 0) {
        if (misses < 10) ratingFC = "SDCB";
        else if (misses >= 10) ratingFC = "Clear";
    }
}
function update(){
    var acc = FlxMath.roundDecimal(Math.max(accuracy, 0) * 100, 2);
    var rating:String = getRating(accuracy);
    getRatingFC(accuracy, misses);
    if (songScore > 0 || acc > 0 || misses > 0) {
        hudTxt.text = "Score: " + songScore + " | Misses: " + misses +  " | Rating: " + rating + " (" + acc + "%)" + " - " + ratingFC;
    } 

}
function onPlayerHit(note) {
hudTxt.color = boyfriendColor;

if (note.noteType == "Pibby"){
    hudTxt.color = pibbyColor;
 }
}