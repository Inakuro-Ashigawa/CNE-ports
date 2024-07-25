static var redirectStates:Map<FlxState, String> = [
    TitleState => "RT/DesktopMenuState",

];
function preStateSwitch() {
		for (redirectState in redirectStates.keys())
			if (FlxG.game._requestedState is redirectState && FlxG.save.data.RTmenus)
				FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}