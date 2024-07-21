//imports
import openfl.text.TextFormat;
import openfl.text.TextField;
import flixel.text.FlxText;
import flixel.text.FlxTextBorderStyle;

var missLimit = 25;
var cantDie = false;
var showHealthBar = true;
var textSize = 25;

function create(){

    limitText = new FlxText(570, 20, 670, "Miss limit:", textSize);
    limitText.alignment = 'left';
    limitText.cameras = [camHUD];
    limitText.color = FlxColor.RED;
    add(limitText);

    limit = new FlxText(630, 60, 670, missLimit, textSize);
    limit.alignment = 'left';
    limit.color = FlxColor.YELLOW;
    limit.cameras = [camHUD];
    add(limit);

    limit.alpha = limitText.alpha = 0;


}
function onSongStart(){
    FlxTween.tween(limit, {alpha: 1}, .5, {ease: FlxEase.linear});
    FlxTween.tween(limitText, {alpha: 1}, .3, {ease: FlxEase.linear});
}
function update(){
	if (misses >= missLimit){
        health = 0;
    }
    if (misses >= missLimit - 1){
        limit.color = FlxColor.RED;
    }
	if (cantDie)
    	if (health <= 0.1 ){
            health = 0.025;
        }
	}