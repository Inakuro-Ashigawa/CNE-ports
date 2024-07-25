var pibbyHealthbar:FlxSprite;
var pibbyHealthbar2:FlxSprite;
var hc1 = new FlxSprite (300, 610).loadGraphic(Paths.image('fw/hc1'));
var hc2 = new FlxSprite (300, 610).loadGraphic(Paths.image('fw/hc2'));
var hc3 = new FlxSprite (300, 610).loadGraphic(Paths.image('fw/hc3'));

//W beep
function snap(f:Float, snap:Float){
    var m:Float = Math.fround(f/snap);
    return (m * snap);
}

//my turn
function postCreate() {
    pibbyHealthbar = new FlxSprite();
    pibbyHealthbar.frames = Paths.getSparrowAtlas('healthbar/healthbarShader', null, true);
    pibbyHealthbar.scale.set(1, 1);
    pibbyHealthbar.updateHitbox();
    for(i in 0...41){
        var indiceStart = i * 3;
        var animFrames = [indiceStart, indiceStart + 1, indiceStart + 2]; 
           pibbyHealthbar.animation.addByIndices(snap((i/40)*100, 2.5) + 'Percent', "healthbar", animFrames, "", 12, true);
           pibbyHealthbar.animation.addByIndices("healthbar0122", "healthbar0122", animFrames, "", 12, true);
        }
    pibbyHealthbar.animation.play("50Percent",true); // 50% damage, cus hp starts at half (1 / 2)
    pibbyHealthbar.x = 65;
    pibbyHealthbar.y = iconP1.y + 50;
    pibbyHealthbar.cameras = [camHUD];
    insert(members.indexOf(healthBar) - 1, pibbyHealthbar);

    //same thing but darwin lmao
    pibbyHealthbar2 = new FlxSprite();
    pibbyHealthbar2.frames = Paths.getSparrowAtlas('healthbar/healthbar2', null, true);
    pibbyHealthbar2.scale.set(1, 1);
    pibbyHealthbar2.updateHitbox();
    for(i in 0...41){
        var indiceStart = i * 3;
        var animFrames = [indiceStart, indiceStart + 1, indiceStart + 2]; 
           pibbyHealthbar2.animation.addByIndices(snap((i/40)*100, 2.5) + 'Percent', "healthbar", animFrames, "", 12, true);
           pibbyHealthbar2.animation.addByIndices("healthbar0122", "healthbar0122", animFrames, "", 12, true);
    }
    pibbyHealthbar2.animation.play("50Percent",true); // 50% damage, cus hp starts at half (1 / 2)
    pibbyHealthbar2.x = 65;
    pibbyHealthbar2.y = iconP1.y + 50;
    pibbyHealthbar2.cameras = [camHUD];
    insert(members.indexOf(healthBar) - 1, pibbyHealthbar2);

    hc = new FlxSprite(-700, -500);
    hc1 = new FlxSprite(-700, -500);
    hc2 = new FlxSprite(-700, -500);
    hc3 = new FlxSprite(-700, -500);
    hc.loadGraphic(Paths.image('fw/hc'));
    hc1.loadGraphic(Paths.image('fw/hc1'));
    hc2.loadGraphic(Paths.image('fw/hc2'));
    hc3.loadGraphic(Paths.image('fw/hc3'));
    hc.scale.set(.04,.04);
    hc1.scale.set(.04,.04);
    hc2.scale.set(.04,.04);
    hc3.scale.set(.04,.04);
    hc.cameras = hc1.cameras = hc2.cameras = hc3.cameras = [camHUD];
    hc.alpha = pibbyHealthbar.alpha = pibbyHealthbar2.alpha = iconP1.alpha = iconP2.alpha = hc1.alpha = hc2.alpha = hc3.alpha = 0.001;
    add(hc);
    add(hc1);
    add(hc2);
    add(hc3);


    healthBar.visible = false;
    healthBarBG.visible = false;
}
public function appear(){
    hc.alpha = pibbyHealthbar.alpha = pibbyHealthbar2.alpha = iconP1.alpha = iconP2.alpha = hc1.alpha = hc2.alpha = hc3.alpha = 1;
}
function create(){
    vocals.volume = 0;
    dad.forceIsOnScreen = true;
}
function postUpdate(){
    iconP1.x = 550;
    iconP2.x = 50;
}
function update(elapsed){

    var healthPercent = health * 0.5; // i would do / 2 but iirc multiplication is more optimized than division in alot of cases
    var damagePercent = 1 - healthPercent;

    pibbyHealthbar.animation.play((snap(damagePercent*100, 2.5)) + "Percent"); // snaps to multiples of 2.5
    pibbyHealthbar2.animation.play((snap(damagePercent*100, 2.5)) + "Percent"); // snaps to multiples of 2.5

    if (health > 1 && pibbyHealthbar.alpha == 1){
        hc.alpha = 1;
        hc1.alpha = 0.001;
    }
    if (health <= 1 && pibbyHealthbar.alpha == 1){
        hc.alpha = hc2.alpha = hc3.alpha = 0.001;
        hc1.alpha = 1;  
    }
    if (health <= .55 && pibbyHealthbar.alpha == 1){
        hc.alpha = hc1.alpha = hc3.alpha = 0.001;
        hc2.alpha = 1;  
    }
    if (health <= .25 && pibbyHealthbar.alpha == 1){
        hc.alpha = hc1.alpha = hc2.alpha = 0.001;
        hc3.alpha = 1;    
    }
}

function onDadHit() {
    if (pibbyHealthbar.alpha == 1)
    pibbyHealthbar2.alpha = 0;
}
function onPlayerHit(){
    if (pibbyHealthbar.alpha == 1)
    pibbyHealthbar2.alpha = 1;
}