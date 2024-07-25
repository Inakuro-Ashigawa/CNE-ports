function onCountdown(event) {// countdown thingy
                switch(event.swagCounter) {
                case 0:
                    camera.zoom += 0.06;
                    bfIntro.playAnim('3', true);
                    pibbyIntro.playAnim('3', true); 
                    boyfriend.alpha = 0.0001; 
                    bfIntro.alpha = 1; 
                    pibbyIntro.alpha = 1; 
                    gf.alpha = 0.0001;
                    countNum.animation.play('3', true);
                    countNum.alpha = 1;

                case 1: 
                    camera.zoom += 0.06; 
                    bfIntro.playAnim('2', true); 
                    pibbyIntro.playAnim('2', true);
                    countNum.animation.play('2', true);

                case 2:
                    camera.zoom += 0.06; 
                    bfIntro.playAnim('1', true); 
                    pibbyIntro.playAnim('1', true);
                    countNum.animation.play('1', true);

                case 3: 
                    FlxTween.tween(camera, {zoom: defaultCamZoom}, 0.05); // for zoom back to their default camZoom
                    bfIntro.playAnim('idle', true); 
                    pibbyIntro.playAnim('idle', true); 
                    camHUD.visible = true; 
                    camHUD.flash(FlxColor.WHITE, 0.25);
                    countNum.animation.play('Go', true);
      }
}
function update(elapsed:Float) {

    switch(curSong){
        case 'suffering-siblings', 'brotherly-love', 'blessed-by-swords', 'what-am-i', 'retcon', 'childs-play':
        if (Conductor.songPosition < 0) {
            curCameraTarget = 1;
            camFollow.setPosition(2100, 1100);
        }
    }
}

function onSongStart() {
boyfriend.alpha = 1;
gf.alpha = 1;
for (i in [bfIntro,pibbyIntro,countNum])
i.alpha = 0.00000000001;
}
function postCreate() {

    FlxG.mouse.visible = false;

    FlxG.cameras.add(camHUD3 = new HudCamera(), false);
    camHUD3.bgColor = FlxColor.TRANSPARENT;

    countNum = new FlxSprite(350, 200);// countdown numbers thingys
    countNum.frames = Paths.getSparrowAtlas('Numbers');
    countNum.animation.addByPrefix('1', '1', 24, false);
    countNum.animation.addByPrefix('2', '2', 24, false);
    countNum.animation.addByPrefix('3', '3', 24, false);
    countNum.animation.addByPrefix('Go', 'Go', 24, false);
    countNum.updateHitbox();
    countNum.alpha = 0.0001;
    countNum.cameras = [camHUD3];
    countNum.antialiasing = true;
    insert(members.indexOf(boyfriend)+1, countNum);
    
    bfIntro = new Character(0, 0, "bfIntro", true);
    bfIntro.alpha = 0.0001;
    insert(members.indexOf(boyfriend)+1, bfIntro);
    
    pibbyIntro = new Character(0, 0, "pibbyIntro", false);
    pibbyIntro.alpha = 0.0001;
    insert(members.indexOf(gf)+1, pibbyIntro);


    bfIntro.x = boyfriend.x;
    bfIntro.y = boyfriend.y;
    pibbyIntro.x = gf.x;
    pibbyIntro.y = gf.y;
}

