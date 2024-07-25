class StupidFuckingCursorDumb extends flixel.FlxSprite
{
	public var mouseInterest:Bool = false;
    public var mouseDisabled:Bool = false;
    public var mouseWaiting:Bool = false;
    public var mouseLockon:Bool = true;

    public var cursorCam:FlxCamera = new FlxCamera();

	public function new(scaleX:Float, scaleY:Float, camera:FlxCamera) {
        frames = Paths.getSparrowAtlas('RT stuff/userinterface/cursor');
        animation.addByPrefix("idle", "idle0", 1, true);
        animation.addByPrefix("idleClick", "idleClick", 1, true);
        animation.addByPrefix("hand", "hand0", 1, true);
        animation.addByPrefix("handClick", "handClick", 1, true);
        animation.addByPrefix("waiting", "waiting", 8, true);
        animation.addByPrefix("disabledClick", "disabledClick", 1, true);
        animation.addByPrefix("disabled", "disabled", 1, true);
        animation.play("idle");

        scrollFactor.set(0, 0); // avoid mouse moving around on its own
        if (camera == null) cameras = [FlxG.camera];
        else cameras = [camera];
        scale.set(scaleX, scaleY);
        
        updateHitbox();
	}

    override function update(elapsed:Float){
        if (FlxG.save.data.customCursor) FlxG.mouse.visible = false;
        else FlxG.mouse.visible = true;

        visible = FlxG.save.data.customCursor;
        
        if (mouseLockon) setPosition(FlxG.mouse.getScreenPosition(camera).x, FlxG.mouse.getScreenPosition(camera).y);

        if (mouseWaiting) {
            animation.play("waiting", true);
        } else {
            animation.play(mouseInterest?"hand":"idle",true);
            if (mouseDisabled) {
                animation.play("disabled",true);
                if (FlxG.mouse.pressed) animation.play("disabledClick",true);
                if (FlxG.mouse.justPressed) FlxG.sound.play(Paths.sound('RT/xp/windowsXPding'), 0.6);
            } else {
                if (FlxG.mouse.pressed) animation.play(mouseInterest?"handClick":"idleClick",true);
                if (FlxG.mouse.justPressed) FlxG.sound.play(Paths.sound('RT/xp/windowsXPclick'), 1);
            }
        }

    }
}
