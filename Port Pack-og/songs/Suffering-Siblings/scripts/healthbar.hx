import funkin.game.HealthIcon;
import openfl.filters.ShaderFilter;
var Distort:CustomShader;
var gfIcons:HealthIcon;


function postCreate() {

    bar = new FlxSprite(190, 580);
    bar.frames = Paths.getSparrowAtlas('PA Stuff/iconbar');
    bar.animation.addByPrefix('bar1', 'Icons Bar0', 24, true);
    bar.scrollFactor.set();
    bar.updateHitbox();
    bar.alpha = 1;
    bar.antialiasing = true;
    bar.cameras = [camHUD];
    insert(members.indexOf(iconP1)-2, bar);
    bar.animation.play('bar1', true, false, 0);

}
function postUpdate(elapsed) {
iconP1.x = 620;
iconP2.x = 520;


healthBar.alpha = 0.00000000001;
healthBarBG.alpha = 0.00000000001;

FlxG.state.forEachOfType(FlxText, text -> text.font = Paths.font("Finn.ttf"));
}

