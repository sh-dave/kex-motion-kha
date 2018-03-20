package kex.motion;

class Velocity {
	public var lastValue(default, null) = 0.0;

	var task = -1;
	var startTime = 0.0;
	var lastTime = 0.0;
	var offset = 0.0;
	var frame = 0.0;

	public function new() {
	}

	public function start( startValue: Float ) {
		kha.Scheduler.removeTimeTask(task);
		task = kha.Scheduler.addTimeTask(step, 0, 1 / 10);
		startTime = kha.Scheduler.time();
		frame = offset = startValue;
	}

	public function drag( value: Float )
		offset = value;

	public function stop( value: Float ) {
		offset = value;
		kha.Scheduler.removeTimeTask(task);
		task = -1;
	}

	public function reset() {
		stop(0);
		lastValue = 0;
	}

	public function setManualSpeed( v: Float )
		lastValue = v;

	function step() {
		lastTime = kha.Scheduler.time();
		var elapsed = lastTime - startTime;
		var delta = offset - frame;
		frame = offset;
		var v = delta / (1 + elapsed);
		lastValue = 0.8 * v + 0.2 * lastValue;
	}
}
