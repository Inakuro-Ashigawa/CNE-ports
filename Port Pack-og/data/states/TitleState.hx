function create(){
if (FlxG.save.data.RTmenus) FlxG.switchState(new ModState("RT/LegacyTitleState"));
if (FlxG.save.data.PAmenus) FlxG.switchState(new ModState("PA/TitleState"));
}
