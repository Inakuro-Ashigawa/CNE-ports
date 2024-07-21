function postCreate(){
    healthBar.alpha = 0;
    healthBarBG.loadGraphic(Paths.image("game/UI/skb/healthBar"));
    healthBarBG.x = 240;
    boyfriend.color = FlxColor.BROWN;
    dad.color = FlxColor.BROWN;

    missesTxt.color = FlxColor.RED;
    scoreTxt.color = FlxColor.YELLOW;
    accuracyTxt.color = FlxColor.YELLOW;
}
function colorfix(){
    defaultCamZoom = 1;
    dad.color = FlxColor.BROWN;
    FlxG.sound.play(Paths.sound('savepoint'),2);
}
function onPlayerHit(event:NoteHitEvent) event.ratingPrefix = "game/UI/skb/"; 