//vars
var useHP = true ;
var notLow = true;

var maxY = 250;
var minY = 520;
var juicePercent = minY - maxY;
var maxScale = 0.65;
var juiceCalc;
var bar,juice,bubs = new FlxSprite(0, 0);

function postCreate(){
    if (useHP)
        health = 2;
}
function create(){
    if (useHP)
        black = new FlxSprite(1142, 170).loadGraphic(Paths.image("healthbar/black"));
        black.scale.set(maxScale,maxScale);
        black.camera = camHUD;
        add(black);

        juice = new FlxSprite(1142, maxY).loadGraphic(Paths.image("healthbar/pink"));
        juice.scale.set(maxScale,maxScale);
        juice.camera = camHUD;
        add(juice);

        bar = new FlxSprite(1000, 90);
        bar.frames = Paths.getSparrowAtlas('healthbar/healthbar');
        bar.animation.addByIndices('idle', 'HEALTHBAR NENE', [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14], "", 24, false);
        bar.animation.addByIndices('idle_low', 'HEALTHBAR NENE', [26,27,28,29,30,31,32,33], "", 24, false);
        bar.animation.addByIndices('itsover', 'HEALTHBAR NENE', [15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33], "", 24, false);
        bar.animation.addByIndices('wereback', 'HEALTHBAR NENE', [34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53], "", 24, false);
        bar.animation.play('idle');
        bar.scale.set(maxScale,maxScale);
        bar.camera = camHUD;

        bubs = new FlxSprite(1141.2, maxY - 40);
        bubs.frames = Paths.getSparrowAtlas('healthbar/healthbar_METER_ANIM');
        bubs.animation.addByPrefix('idle', "HEALTH METER ANIM", 24, true);
        bubs.animation.play('idle');
        bubs.scale.set(maxScale,maxScale);
        bubs.camera = camHUD;
        add(bubs);
        add(bar);
}
function postCreate(){
    iconP1.alpha = iconP2.alpha = healthBar.alpha = healthBarBG.alpha = 0;
}
function update(elapsed){
    juiceCalc = maxY + (juicePercent - (juicePercent*health/2.1));
    bubs.y = juice.y + 40;
    juice.scale.set(0.65, 0.20 + (maxScale * health/2));
    juice.y = juiceCalc;
}
function onPlayerHit(){
    juice.y = juiceCalc;
}


function onNoteMiss(){
    juice.y = juiceCalc;
    if (health > 0.0182){
        health- 0.01;
    }
}
function beatHit(curBeat){
    
    if (curBeat % 2 == 0 && useHP){
		if (notLow){
            bar.animation.play('idle');
        }else{
        bar.animation.play('idle_low');
        }
    }
}