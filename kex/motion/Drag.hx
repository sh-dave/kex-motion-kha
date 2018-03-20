package kex.motion;

class Drag {
	var active = false;

	public function new() {
	}

	public function start()
		active = true;

	public function stop()
		active = false;

	public function update( value: Float, delta: Float ) : Float {
		if (active) {
			value += delta;
		}

		return value;
	}
}
