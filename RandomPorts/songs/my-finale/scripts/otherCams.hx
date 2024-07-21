import Date;


function create(){
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(camCinema = new HudCamera(), false);
    camCinema.bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.add(camHUD, false);

    FlxG.cameras.add(camHUD2 = new FlxCamera(), false);
    camHUD2.bgColor = FlxColor.TRANSPARENT;
}
function postUpdate(){
    camHUD2.scroll = camHUD.scroll;
    camCinema.scroll = camHUD.scroll;
    camCinema.zoom = camHUD.zoom;
}

function postCreate() {

    CNlogo = new FlxSprite(990, 600);
    CNlogo.loadGraphic(Paths.image("logos/CNlogo"));
    CNlogo.setGraphicSize(Std.int( CNlogo.width * 0.17));
    CNlogo.updateHitbox();
    CNlogo.alpha = 0.5;
    CNlogo.cameras = [camHUD2];
    add(CNlogo);

    var leDate = Date.now();
    if (leDate.getHours() >= 17 && leDate.getHours() <= 24) {
        CNlogo.loadGraphic(Paths.image('logos/aslogo'));
        CNlogo.x = 1046.5;
        CNlogo.y = 660;
        CNlogo.setGraphicSize(Std.int( CNlogo.width * 0.09));
        CNlogo.updateHitbox();
        
        trace( CNlogo.y);
    }

    if (leDate.getHours() >= 1 && leDate.getHours() <= 6) {
        CNlogo.loadGraphic(Paths.image('logos/aslogo'));
        CNlogo.x = 1046.5;
        CNlogo.y = 660;
        CNlogo.setGraphicSize(Std.int( CNlogo.width * 0.09));
        CNlogo.updateHitbox();
        
    }

    if (leDate.getHours() >= 6 && leDate.getHours() <= 17) {
        CNlogo.loadGraphic(Paths.image('logos/CNlogo'));
        CNlogo.x = 990;
        CNlogo.y = 600;
        CNlogo.setGraphicSize(Std.int( CNlogo.width * 0.17));
        CNlogo.updateHitbox();
        
    }
}