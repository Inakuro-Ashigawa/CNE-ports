import openfl.text.TextFormat;
import openfl.display.Sprite;
import openfl.text.TextField;

class CodenameBuildField extends TextField {
	public function new() {
		super();
		defaultTextFormat = Framerate.textFormat;
		autoSize = LEFT;
		multiline = wordWrap = false;
		text = 'Codename Engine \n Port Pack Beta';
	}
}
