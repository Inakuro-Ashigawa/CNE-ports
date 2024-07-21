//imports
import openfl.text.TextFormat;
import openfl.text.TextField;
import flixel.text.FlxText;
import flixel.text.FlxTextBorderStyle;
import funkin.game.HudCamera;

//vars
var camOther = new FlxCamera();

var scale = 0.5;
var gooY = 450;
var scoreY = 530;
var missY = 620;
var doodsY = 450;
var scoree:FlxText;

function postCreate(){
  if (!downscroll){
    gooY = 450;
    scoreY = 530;
    missY = 620;
    doodsY = 450;
  }else{
    gooY = 0;
    scoreY = 10;
    missY = 100;
    doodsY = -70;
  }
  FlxG.cameras.add(camOther = new FlxCamera(), false);
  camOther.bgColor = FlxColor.TRANSPARENT;

  nenegoo = new FlxSprite(0, gooY).loadGraphic(Paths.image("scoreHUD/goo"));
  if (downscroll) nenegoo.flipY = true;
  nenegoo.cameras = [camOther];
  add(nenegoo);

  nenescore = new FlxSprite(20, scoreY).loadGraphic(Paths.image("scoreHUD/score"));
  nenescore.scale.set(scale,scale);
  nenescore.cameras = [camOther];
  add(nenescore);

  nenemiss = new FlxSprite(20, missY).loadGraphic(Paths.image("scoreHUD/miss"));
  nenemiss.scale.set(scale,scale);
  nenemiss.cameras = [camOther];
  add(nenemiss);


  scoree = new FlxText(155, nenescore.y + 85, 0, "", 60);
  scoree.setFormat(Paths.font("Quadrangle.otf"), 60, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
  scoree.scale.set(scale,scale);
  scoree.updateHitbox();
  scoree.cameras = [camOther];
  scoree.borderSize = 2;
  add(scoree);

  misse = new FlxText(155, nenescore.y + 154, 0, "", 60);
  misse.setFormat(Paths.font("Quadrangle.otf"), 60, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
  misse.scale.set(scale,scale);
  misse.updateHitbox();
  misse.cameras = [camOther];
  misse.borderSize = 2;
  add(misse);
  
  remove(scoreTxt);
	remove(missesTxt);
	remove(accuracyTxt);

}
function update(elapsed:Float) {
  scoree.text = songScore;
  misse.text = misses;

}