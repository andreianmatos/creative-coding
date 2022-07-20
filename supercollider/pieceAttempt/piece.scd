s.boot;
s.meter;
s.plotTree;

(
SynthDef(\bpfsaw, {
	arg atk=2, sus=0, rel=3, c1=1, c2=(-1), freq=500, detune=0.2, pan=0, cfhzmin = 0.1, cfhzmax=0.3,
cfmin = 500, cfmax=2000, rqmin=0.1, rqmax=0.2, amp=1, out=0;
	var sig, env;
	env = EnvGen.kr(Env([0,1,1,0], [atk, sus, rel], [c1, 0, c2]), doneAction:2);
	sig = Saw.ar(freq * {LFNoise1.kr(0.5, detune).midiratio}!2);
	sig = BPF.ar(
		sig,
		{LFNoise1.kr(
			LFNoise1.kr(4).exprange(cfhzmin, cfhzmax)
			).exprange(cfmin, cfmax)}!2,
		{LFNoise1.kr(0.1).exprange(rqmin, rqmax)}!2
	); //band pass filter
	sig = Balance2.ar(sig[0], sig[1], pan);
	sig = sig * env * amp;
	Out.ar(out, sig);
}).add;
)

Synth(\bpfsaw);
2.do{Synth(\bpfsaw, [\amp, 0.2, \detune, 0])};
12.do{Synth(\bpfsaw, [\amp, 0.2, \detune, 4])};


(
10.do{
	Synth(
		\bpfsaw,
		[
			\freq, 200,
			\amp, 0.5,
			\cfmin, 50,
			\cfmax, 50*2,
			\rqmin, 0.1,
			\rqmax, 0.5,
			\cfhzmin, 1,
			\cfhzmax, 2,
		]
	)
};
)

Scale.major;
Scale.directory;

(
(1..6).choose.do{
	arg f;
	Synth(
		\bpfsaw,
		[
			\freq, (Scale.minor.degrees+60).midicps.choose,
			\amp, 0.25,
			\cf, exprand(200, 5000),
			\rq, exprand(0.01, 0.5),
		]
	);
};
)


//sawtooth wave with low freq values we dont stop hearing sound, just stop perceiving pitch and only perceive rythm
(
Synth.new(
	\bpfsaw,
	[
		\freq, 2,
		\atk, 0,
		\rqmin, 0.005,
		\rqmax, 0.008,
		\cfmin,880,
		\cfmax,880,
	]
);
)

//building another pattern

(
~chords = Pbind(
	\instrument, \bpfsaw,
	\dur, Pwhite(4.5, 7.0, inf),
	\midinote, Pxrand([
		[23, 61, 56],
		[28,60, 40, 63],
		[56, 78],
		[42, 52, 57, 61, 63],
	],inf), //inf makes all internal patterns infinite, chords will play forever
	\detune, Pexprand(0.05, 0.2, inf),
	\cfmin, 100,
	\cfmax, 1500,
	\rqmin, Pexprand(0.01, 0.15, inf),
	\atk, Pwhite(2.0, 2.5, inf),
	\rel, Pwhite(6.5, 10.0, inf),
	\ldb, 6,
	\amp, 0.2,
	\out, 0,
).play;

(
~marimba = Pbind(
	\instrument, \bpfsaw,
	\dur, Pwhite(0.5, 2, inf),
	\freq, Prand([1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377],inf),
	\detune, Pwhite(0,0.1,inf),
	\rqmin, 0.005,
	\rqmax, 0.008,
	\cfmin, Prand((Scale.major.degrees+64).midicps, inf) * Prand([0.5, 1, 2, 4], inf),
	\cfmax, Pkey(\cfmin) * Pwhite(1.008, 1.025, inf),
	\atk, Pwhite(2.0, 2.5, inf),
	\sus, 1,
	\rel, Pwhite(6.5, 10.0, inf),
	\amp, 1,
	\out, 0,
).play;
)

~marimba.stop;
~chords.stop;
