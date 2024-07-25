function onCountdown(event) {// countdown thingy
    camHUD.alpha = 0;
    switch(curSong){
        case 'suffering-siblings', 'brotherly-love', 'blessed-by-swords', 'what-am-i':
            switch(event.swagCounter) {
                case 0:
                    trace("Countdown Starts");
                    camera.zoom += 0.06;
                    bfIntro.playAnim('3', true);
                    gf.playAnim('gf dodge'); 
                    boyfriend.alpha = 0.0001; 
                    bfIntro.alpha = 1; 
                    countNum.animation.play('3', true);
                    countNum.alpha = 1;

                case 1: 
                    camera.zoom += 0.06; 
                    bfIntro.playAnim('2', true); 
                    gf.playAnim('gf pre attack');
                    countNum.animation.play('2', true);

                case 2:
                    camera.zoom += 0.06; 
                    bfIntro.playAnim('1', true); 
                    gf.playAnim('gf attack');
                    countNum.animation.play('1', true);

                case 3: 
                    FlxTween.tween(camera, {zoom: defaultCamZoom}, 0.1); // for zoom back to their default camZoom
                    bfIntro.playAnim('go'); 
                    gf.playAnim('hey'); 
                    camHUD.visible = true; 
                    camHUD.flash(FlxColor.WHITE, 0.25);
                    countNum.animation.play('Go', true);

                case 4:
                    boyfriend.alpha = camHUD.alpha = 1;
                    bfIntro.alpha = 0.001;  
                    countNum.alpha = 0.001;
            }
        
        case 'retcon', 'childs-play':
            switch(event.swagCounter) {
                case 0:
                    trace("Countdown Starts");
                    camera.zoom += 0.06;
                    bfIntro.playAnim('3', true);
                    gf.playAnim('gf dodge'); 
                    boyfriend.alpha = 0.0001; 
                    bfIntro.alpha = 1; 
                    countNum.animation.play('3', true);
                    countNum.alpha = 1;

                case 1: 
                    camera.zoom += 0.06; 
                    bfIntro.playAnim('2', true); 
                    gf.playAnim('gf pre attack');
                    countNum.animation.play('2', true);

                case 2:
                    camera.zoom += 0.06; 
                    bfIntro.playAnim('1', true); 
                    gf.playAnim('gf attack');
                    countNum.animation.play('1', true);

                case 3: 
                    if (curSong != 'retcon') FlxTween.tween(camera, {zoom: defaultCamZoom}, 0.1);
                    if (curSong == 'retcon') FlxTween.tween(camera, {zoom: .9}, 0.1);
                    bfIntro.playAnim('go'); 
                    gf.playAnim('hey'); 
                    countNum.animation.play('Go', true);
                case 4:
                    boyfriend.alpha = camHUD.alpha = 1;
                    bfIntro.alpha = 0.001; 
                    countNum.alpha = 0.001;
            }

        default:
            trace("Countdown Starts");
            switch(event.swagCounter) {
                
                case 0:
                        countNum.animation.play('3', true);
                        countNum.alpha = 1;
    
                case 1: 
                        countNum.animation.play('2', true);
    
                case 2:
                        countNum.animation.play('1', true);
    
                case 3: 
                        countNum.animation.play('Go', true);

                case 4:
                    countNum.alpha = 0.001;
        }   
    }
}
function create(){
    Conductor.changeBPM(80);
}
function postCreate() {
    Conductor.changeBPM(80);
    switch(curSong){
        case 'suffering-siblings', 'brotherly-love', 'blessed-by-swords', 'what-am-i', 'retcon', 'childs-play':
            curCameraTarget = 1;
    }
}
function onSongStart(){
    trace("Countdown Ends");

    Conductor.changeBPM(Conductor.bpm);
    camHUD.alpha = 1;

    if (curSong != 'suffering-siblings')
        curCameraTarget = 0;
}