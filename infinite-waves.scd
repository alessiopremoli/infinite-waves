s.boot;

(
SynthDef.new(\default, {
	arg dur, attack=0.01, release=1.0,
	t_gate=1, out, freq=442, cutoff=5500,
	rq=1, pan=0.0, amp=0.5;

	var env = EnvGen.kr(
		Env.perc(attack, release),
		t_gate,
		timeScale: dur,
		doneAction: 2
	);
	var sig = DPW3Tri.ar(freq: freq, mul: env);
	sig = RLPF.ar(sig, cutoff.clip(20.0, 20000.0), rq.clip(0.0,1.0));
	sig = Pan2.ar(sig, pan);
	Out.ar(out, sig * amp);
}).add;
)

(
Pdef(\leftSynths,
	Pbind(
		\degree, Prand([1, 4, 8], repeats: inf) - 12,
		\dur, Prand([10, 15, 16], repeats: inf),
		\attack, 0.3 * Pkey(\dur),
		\release, 0.31 * Pkey(\dur),
		\out, 0
	)
).play
)

(
Pdef(\rightSynths,
	Pbind(
		\degree, Prand([1, 4, 8], repeats: inf),
		\dur, Prand([10, 15, 16], repeats: inf),
		\attack, 0.3 * Pkey(\dur),
		\release, 0.31 * Pkey(\dur),
		\out, 1
	)
).play
)