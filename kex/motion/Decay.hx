package kex.motion;

import kex.Macros.select;

// https://ariya.io/2013/11/javascript-kinetic-scrolling-part-2

private typedef DecayProps = {
	?velocity: Float,
	?power: Float,
	?timeConstant: Float,
	?restDelta: Float,
}

class Decay {
	var active = false;
	var timeConstant: Float;
	var restDelta: Float;
	var elapsed: Float;
	var amplitude: Float;
	var target: Float;

	public function new() {
	}

	public function start( startValue: Float, ?props: DecayProps ) {
		props = props != null ? props : {}
		var velocity = select(props.velocity, 0);
		var power = select(props.power, 0.8);
		amplitude = power * velocity;
		target = Math.round(startValue + amplitude);
		timeConstant = select(props.timeConstant, 350);
		restDelta = select(props.restDelta, 0.5);
		elapsed = 0;
		active = true;
	}

	public function stop()
		active = false;

	public function update( value: Float, dt: Float ) : Float {
		if (active) {
			elapsed += dt * 1000;
			var delta = -amplitude * Math.exp(-elapsed / timeConstant);
			var isMoving = (delta > restDelta || delta < -restDelta);
			var current = isMoving ? target + delta : target;
			value = current;

			if (!isMoving) {
				active = false;
			}
		}

		return value;
	}
}
