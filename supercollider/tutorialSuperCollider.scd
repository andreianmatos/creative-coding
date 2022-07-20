/* TUTORIAL 2*/
(
z = {
	arg noiseHz = 8;
	var freq, amp, sig;
	freq = LFNoise0.kr(noiseHz).exprange(200, 1000);
	amp = LFNoise1.kr(12).exprange(0.02,1);
	sig = SinOsc.ar(freq);
}.play;
)

(
SynthDef.new(\sineTest, {
	arg noiseHz = 8;
	var freq, amp, sig;
	freq = LFNoise0.kr(noiseHz).exprange(200, 1000);
	amp = LFNoise1.kr(12).exprange(0.02,1);
	sig = SinOsc.ar(freq);
	Out.ar(0, sig); //index 0 corresponds to lowest hardware output, 0 left speaker, 1 right speaker
}).add;
)

x = Synth.new(\sineTest, [\noiseHz, 32]);

// to update values while synth is active
x.set(\noiseHz, 12);

x.free;



/* TUTORIAL 3*/

(
SynthDef.new(\pulseTest, {
	arg ampHz = 4, fund = 40, maxPartial = 4, width = 0.5;
	var amp1, amp2, freq1, freq2, sig1, sig2;
	// add the LFPulse to amplitude so tha t it isnt steady pulses of sound; short pulses because cycle is close to 0;  the pulse waves are out of phase (0, 0.5) so the sound alternates between the left and right
	amp1 = LFPulse.kr(ampHz, 0, 0.12)*0.75;
	amp2 = LFPulse.kr(ampHz, 0.5, 0.12)*0.75;
	freq1 = LFNoise0.kr(4).exprange(fund, fund*maxPartial).round(); //non interpolated noise with a new value chosen 4x per second, LFNoise0 is random value generator, even tho the following ues it as well they will be 2 different values
	freq2 = LFNoise0.kr(4).exprange(fund, fund*maxPartial).round();
	//LFPulse to add some jumps, it usually ranges from 0 to 1, add 1 makes it range from 1 to 2
	freq1 = freq1 * LFPulse.kr(8, add:1);
	freq2 = freq2 * LFPulse.kr(6, add:1);
	sig1 = Pulse.ar(freq1, width, amp1);
	sig2 = Pulse.ar(freq2, width, amp2);
	// add reverb to sound a little nice
	sig1 = FreeVerb.ar(sig1, 0.7, 0.8, 0.25);
	sig2 = FreeVerb.ar(sig2, 0.7, 0.8, 0.25);
	Out.ar(0, sig1); // left ear
	Out.ar(1, sig2); // signal to right ear
}).add;
)

x = Synth.new(\pulseTest);

//alter the values while its paying
x.set(\width, 0.15);
x.set(\fund, 50);
x.set(\maxPartial, 20);
x.set(\ampHz, 2);

x.free;

// to initilize the synth with different values than the default ones
x = Synth.new(\pulseTest, [\ampHz, 3.3, \fund, 48, \maxPartial, 4, \width, 0.15]);


/* TUTORIAL 4*/

// s is always Server.local
s.boot;

s.plotTree;

x = {PinkNoise.ar * 0.1}.play;

x.free;

(
x = {
	var sig, freq, env;
	// done action 0 means the synth is not freed; 2 frees it at the end of the line
	// XLine is exponential value of Line, sounds more natural because we perceive amplitude and frequency exponentially
	env = XLine.kr(1, 0.01, 5, doneAction:2);
	freq = XLine.kr(880, 110, 1, doneAction:0);
	sig = Pulse.ar(freq) *env;
}.play;
)

// ampdb and dbamp to convert from amplitude to decibles and vice versa

//or Ctrl .
s.freeAll;

(
x ={
	// gate retriggers the envelope to start, for this it switches from a non positive value to a positive value (0/1)
	// t_ values are trigger values, when i set it to to 1 it will be set to 0 in the next value
	arg t_gate = 0;
	var sig, env;
	env = EnvGen.kr(Env.new(
		[0, 1, 0.2, 0],
		[0.5, 1, 2],
		[3, -3, 0]),
	    gate);
	sig = Pulse.ar(LFPulse.kr(8).range(600, 900)) * env;
}.play;
)

Env.new([0, 1, 0.2, 0], [0.5, 1, 2], [3, -3, 0]).plot;

x.set(\t_gate, 1);

x.free;

(
x ={
	// gate retriggers the envelope to start, for this it switches from a non positive value to a positive value (0/1)
	// t_ values are trigger values, when i set it to to 1 it will be set to 0 in the next value
	arg gate = 0;
	var sig, env, freq;
	freq = EnvGen.kr(Env.adsr(1), gate, 200,0.1);
	env = EnvGen.kr(Env.adsr, gate);
	sig = VarSaw.ar(SinOsc.kr(freq).range(500, 1000)) * env;
}.play;
)
x.set(\gate, 0);



/* TUTORIAL 5 */
s.boot;

// to see the channels
s.meter;

//left ear: 300, right: 500
x = {SinOsc.ar([300,500])}.play;

// the amplitude of the 300hz tone in left speaker flunctuates 7 times per econd, the 500hz tone in the right speaker functuates once per second
(
x = {
	var sig, amp;
	amp = SinOsc.kr([7, 1]).range(0.1);
	sig = SinOsc.ar([300,500]);
	sig = sig * amp;
}.play;
)

// we only hear as many channels are there are spekaers but if we had more we can use mix that mixes the discrete signals to a single channel, *0.25 to avoid clipping, but now we're back to a monophonic sound
(
x = {
	var sig, amp;
	amp = SinOsc.kr([7, 1, 2, 0.2, 6]).range(0.1);
	sig = SinOsc.ar([300,500, 700, 900, 1100]);
	sig = sig * amp;
	Mix.new(sig) * 0.25;
}.play;
)
//multi channel expansion to the mixed signal
(
x = {
	var sig, amp;
	amp = SinOsc.kr([7, 1, 2, 0.2, 6]).range(0.1);
	sig = SinOsc.ar([300,500, 700, 900, 1100]);
	sig = sig * amp;
	[Mix.new(sig), Mix.new(sig)] * 0.25;
}.play;
)

x.free;

//dup returns an array of duplicates, same as above or also could be written like
// Mix.new(sig)!2 * 0.25
(
x = {
	var sig, amp;
	amp = SinOsc.kr([7, 1, 2, 0.2, 6]).range(0.1);
	sig = SinOsc.ar([300,500, 700, 900, 1100]);
	sig = sig * amp;
	Mix.new(sig).dup(2) * 0.25;
}.play;
)

// splay is similar to mix but more complex sound bc it will spread an ribitrarly large array of channels across a stereo field
(
x = {
	var sig, amp;
	amp = SinOsc.kr([7, 1, 2, 0.2, 6]).range(0.1);
	sig = SinOsc.ar([300,500, 700, 900, 1100]);
	sig = sig * amp;
	Splay.ar(sig) * 0.25;
}.play;
)

// same output both channels
x = {PinkNoise.ar(0.5)!2}.play;
// unique output to each channel
x = {PinkNoise.ar(0.5!2)}.play;

// array of 4 copies of random value
rrand(50, 1200)!4;
// array of uniquely genersted random numbers bc {} make it a function
{rrand(50, 1200)}!4;

// in a synth def we need an output; Out.ar([0,1])... wrong
(
SynthDef.new(\multi, {
	var sig, amp;
	amp = SinOsc.kr({exprand(0.2, 12)}!8).range(0.1);
	sig = SinOsc.ar({exprand(0.2, 12)}!8);
	sig = sig * amp;
	Splay.ar(sig) * 0.25;
	Out.ar(0, sig);
}).add;
)
// exprand isnt the best option for synth def becuase they stay de the same for every synth created from the synthdef

x= Synth.new(\multi);

x.free;

//ExpRand with upper case creates new random values when the synth is created
(
SynthDef.new(\multi, {
	var sig, amp, env;
	env = EnvGen.kr(
		Env.new([0.1,0],[10,10],[1, -1]),
		doneAction:2
	);
	amp = SinOsc.kr({ExpRand(0.2, 12)}!8).range(0.1);
	sig = SinOsc.ar({ExpRand(50, 1200)}!8);
	sig = sig * amp;
	Splay.ar(sig) * 0.5;
	Out.ar(0, sig);
}).add;
)

/* TUTORIAL 6 - ITERATION */

(
x = Array.newClear(5);

[6, 4, 0.5, 10, 7].do{
	arg.item, count;
	x[count] = item.squared;
}
)

z = [6, 4, 0.5, 10, 7].collect(_.squared);

// see, the same
5.do{arg item; item.postln};
[0, 1, 2, 3, 4].do{arg item; item.postln};

x = {VarSaw.ar(40!2, 0, 0.05)}.play;
x.free;

(
SynthDef.new(\iter, {
	arg freq = 40;
	var temp, sum, env;
	sum = 0;
	env = EnvGen.kr(
		Env.perc(0.01, 5, 1, -2),
		doneAction: 2
	);
	10.do{
		temp = VarSaw.ar(
			freq * {Rand(0.99, 1.02)}!2,
			{Rand(0.0, 1.0)}!2,
			{ExpRand(0.005, 0.05)}!2
		);
		sum = sum + temp;
	};
	sum = sum * 0.05 * env; //not to clip
	Out.ar(0, sum);
}).add;
)

Synth.new(\iter, [\freq, 224]);
// convert from midi to hz
x = Synth.new(\iter, [\freq, 75.midicps]);
x.free;

// do to create to simulstaneous synths
// not recommended, lose sample accuracy
(
[53, 59, 63, 68].do{
	arg midinote;
	Synth.new(\iter, [\freq, midinote.midicps]);
}
)

// this incorporated the iteration count into the audio manipulation, dont need a 2nd arg for iteration count because we have the item from the do
// we can do this with Blip.ar(...) but with iteration we have more control over the individuals parcels
(
SynthDef.new(\iter2, {
	arg freq = 200, dev = 1.02; // to choose the frequency and frequecy deviation
	var temp, sum;
	sum = 0;
	10.do{
		arg count; //starts at 0
		temp = SinOsc.ar(
			freq *
			(count+1) *
			LFNoise1.kr({Rand(0.05, 0.2)}!2).range(dev.reciprocal,dev) // 2 unique chanels of audio
		);
		// now make amplitude of each parcel flunctuate randomly
		temp = temp * LFNoise1.kr({Rand(0.5, 8)}!2).exprange(0.01,1);
		sum = sum + temp;
	};
	sum = sum * 0.05;
	Out.ar(0, sum);
}).add;
)

x = Synth.new(\iter2);
x.set(\dev, 1.3);

/* TUTORIAL 7
NODES, BUSSES, ORDER OF EXECUTION
nodes -> synth, group
busses -> pass signals between synths
order of exec -> ordering of the nodes on the server
*/

s.boot;
s.plotTree;
s.meter;

//pass signal from one synth to the other
(
SynthDef.new(\blip, {
	arg out;
	var freq, trig, sig;
	freq = LFNoise0.kr(3).exprange(300,1200).round(300);
	sig = SinOsc.ar(freq) * 0.25;
	trig = Dust.kr(2);
	sig = sig * EnvGen.kr(Env.perc(0.01, 0.2), trig);
	Out.ar(out, sig);
}).add;

SynthDef.new(\reverb, {
	arg in, out = 0;
	var sig;
	sig = In.ar(in, 1);
	sig = FreeVerb.ar(sig, 0.5, 0.8, 0.2)!2;
	Out.ar(out, sig);
}).add;
)

s.options.numAudioBusChannels;
s.options.numOutputBusChannels = 4;
s.options.numInputBusChannels = 2;

s.reboot;
s.meter;

// can be problematic to use an int for bus
y = Synth.new(\reverb, [\in, 6]);
x = Synth.new(\blip, [\out, 6]);
x.free;
y.free;

~reverbBus = Bus.audio(s, 1);
~reverbBus.index;

// .index is autoamtic
y = Synth.new(\reverb, [\in, ~reverbBus]);
x = Synth.new(\blip, [\out, ~reverbBus]);
x.free;
y.free;

// for multichanel uGens

//pass signal from one synth to the other
(
SynthDef.new(\blip, {
	arg out;
	var freq, trig, sig;
	freq = LFNoise0.kr(3).exprange(300,1200).round(300);
	sig = SinOsc.ar(freq) * 0.25;
	trig = Dust.kr(2);
	sig = sig * EnvGen.kr(Env.perc(0.01, 0.2), trig);
	//this
	sig = Pan2.ar(sig, LFNoise1.kr(10));
	Out.ar(out, sig);
}).add;

SynthDef.new(\reverb, {
	arg in, out = 0;
	var sig;
	sig = In.ar(in, 2); //now reading two channels instead of 1
	sig = FreeVerb.ar(sig, 0.5, 0.8, 0.2)!2;
	Out.ar(out, sig);
}).add;
)

// no such thing as a multichannel bus, if we use 1 it all works the same
~reverbBus2 = Bus.audio(s, 2);

y = Synth.new(\reverb, [\in, ~reverbBus2],\addAfter);
x = Synth.new(\blip, [\out, ~reverbBus2]);
x.free;
y.free;

//BOTTOM LINE: user's responsability to make sure the number of channels matches the number of buses and there are no overlaps

//ORDER OF EXECUTION: if a synth depends on the output of another synth,\in comes before \out (?) the effect synth mut end up after the sound source, user \addToTail and \addAfter
8.do{
	Synth.new(
		\blip,
		[
			\out, ~reverbBus2,
			\fund, exprand(60, 300).round(30)
		],
		~sourceGrp
	);
}

~sourceGrp = Group.new;
~fxGrp = Group.after(~sourceGrp);
~sourceGrp.freeAll;

/* TUTORIAL 8 BUFFERS for recorded sound */

s.boot;

//sound files in wav or aiff format

//drag and drop file to automatically get path
~b0 = Buffer.read(s, "");

~b0.play;

~b0.zero; // clears the buffer, to add sound, do read again

~b0.free; //remove it, just like with synths

Buffer.freeAll; //remove all

// every buffer has a certain number of frames, corresponding to their length
~b0.numFrames;
//same for channels
~b0.numChannels;

numSamples = numFrames * numChannels;

//duration in seconds
~b0.duration;

//buffer numbers (bufnums)assigned in order as of when created the buffers, each buffer has a unique id at any moment
~b0.bufnumb;

//buffer sample rate
~b0.sampleRate;
s.sampleRate;

//summary of all
~b0.query;

//how to add only parts of sound into buffer
~b0_part0 = Buffer.read(s, "", 0, s.sampleRate/2);// or by numFrames subtraction

//how to load a lot of soundfiles all at once
// array

~bells = Array.new;
~folder = Pathname.new("");
(
~folder.entries.do({
	arg path;
	~bells = ~bells.add(Buffer.read(s,path.fullPath));
});
)
~bells.at(0).play;
~bells[0].play;

s.options.numBuffers; //max (?)

(
SynthDef.new(\playbuf_test, {
	arg amp = 1, out = 0, buf, rate = 1, t_trig = 1, start = 0, loop = 0, da = 2;
	var sig;
	sig = PlayBuf.ar(2, buf, BufRateScale.kr(buf) * rate, t_trig, start, loop, doneAction: da);
	sig = sig * amp;
	Out.ar(out, sig);
}).add;
)

//fails silently because they dont have the same number of sa mples
Synth.new(\playbuf_test, [\buf, ~b0.bufnum, \rate, 2]);

Synth.new(\playbuf_test, [\buf, ~b0.bufnum, \loop, 1]);

12.midiratio;
-12.midiratio;
// with midiration we can transpose sounds by semitones


Synth.new(\playbuf_test, [\buf, ~b0.bufnum, \rate, -7.midiratio]);

s.freeAll;

//we can create groups of buffers too, see tutorial

(
SynthDef.new(\bufrd_test, {
	arg amp = 1, out = 0, buf, start, end;
	var sig, ptr;
	ptr = Line.ar(start, end, BufDur.kr(buf), doneAction:2);
	sig = BufRd.ar(2, buf, ptr);
	sig = sig * amp;
	Out.ar(out, sig);
}).add;
)

//Line cant loop, Phasor can
//alternatives to phasor: sweep and lfsaw

(
SynthDef.new(\bufrd_loop, {
	arg amp = 1, out = 0, buf, start, end, rate = 1;
	var sig, ptr;
	ptr = Phasor.ar(0, BufRateScale.kr(buf)*rate, start, end);
	sig = BufRd.ar(2, buf, ptr);
	sig = sig * amp;
	Out.ar(out, sig);
}).add;
)

//but any audio rate ugen can be used as a frame pointer, lets use sineosc

(
SynthDef.new(\bufrd_sine, {
	arg amp = 1, out = 0, buf, start, end, freq = 1;
	var sig, ptr;
	ptr = SinOsc.ar(freq, 3pi/2).range(start,end);
	sig = BufRd.ar(2, buf, ptr);
	sig = sig * amp;
	Out.ar(out, sig);
}).add;
)

//noise generator as a buffer playbackpoint, using a linearly interpolationg low frequency noise generator lfdnoise1 we hear random sections of the file at random speed, sometimes forward sometimes backwards
(
SynthDef.new(\bufrd_noise, {
	arg amp = 1, out = 0, buf, start, end, freq = 1;
	var sig, ptr;
	ptr = LFDNoise1.ar(freq).range(start, end);
	sig = BufRd.ar(2, buf, ptr);
	sig = sig * amp;
	Out.ar(out, sig);
}).add;
)

(
SynthDef.new(\bufrd_noise_voice, {
	arg amp = 1, out = 0, buf, start, end, freq = 1;
	var sig, ptr;
	sig = BufRd.ar(2, buf, Prand([start,end]), inf);
	sig = sig * amp;
	Out.ar(out, sig);
}).add;
)


x = Synth.new(\bufrd_test, [\buf, ~b0.bufnum, \start, 0, \end, ~b0.numFrames-1]);

x = Synth.new(\bufrd_loop, [\buf, ~b0.bufnum, \start, 0, \end, ~b0.numFrames-1]);
x.set(\start, ~b0.numFrames/2, \end, ~b0.numFrames-1);
x.set(\start, 2000, \end, 25000);
x.set(\rate, -7.midiratio);


x = Synth.new(\bufrd_sine, [\buf, ~b0.bufnum, \start, 0, \end, ~b0.numFrames-1, \freq, 0.2]);
y = Synth.new(\bufrd_sine, [\buf, ~b0.bufnum, \start, 0, \end, ~b0.numFrames-1, \freq, 0.2]);
 zzzw = Synth.new(\bufrd_sine, [\buf, ~b0.bufnum, \start, 0, \end, ~b0.numFrames-1, \freq, 3]);

s.freeAll;

x.free;
y.free;
z.free;

// the higher the frequency the faster the playback pointer will move, more chaotic

z = Synth.new(\bufrd_noise, [\buf, ~b0.bufnum, \start, 0, \end, ~b0.numFrames-1, \freq, 1]);


/* TUTORIAL 10 PATTERNS*/

(
SynthDef(\sine, {
	arg freq = 440, atk = 0.005, rel = 0.3, amp = 1, pan = 0;
	var sig, env;
	sig = SinOsc.ar(freq);
	env = EnvGen.kr(Env.new([0,1,0],[atk, rel],[1,-1]),doneAction:2);
	sig = Pan2.ar(sig, pan, amp);
	sig = sig * env;
	Out.ar(0,sig);
}).add;
)

(
p = Pbind(
	\type, \note, //Pseq creates a pattern with the values given
	// if the arrays arent the same size they'll just be out of phase
	//"inf" for infinitely loop of the values, or number for number of times
	\dur, Pseq([0.6, 0.15, 0.15], inf).trace, //trace to print the pattern
	//[60, 65, 67, 76].midicps or \midinote, Pseq([60,65,67,74], inf)
	\freq, Pseq([330, 247, 370], inf).trace,
).play;
)

s.plotTree;

p.stop;


// \freq, Pexprand(50, 4000, inf).round(55).trace, // can use math operations like round on patterns
// same as the midinote with the harmonic
(
p = Pbind(
	\instrument, \sine,
	\dur, Pwhite(0.05, 0.5, inf),
	\midinote, 33,
	\harmonic, Pexprand(1, 80, inf).round.trace,
	\atk, Pwhite(2.0, 3.0, inf),
	\rel, Pwhite(5.0, 10.0, inf),
	// amplitude relying on the other harmonic pattern,
	\amp, Pkey(\harmonic).reciprocal * 0.3,
	\pan, Pwhite(-0.8, 0.8, inf),
).play;
)

//to be able to alter a Pbind while its playing
(
Pdef(
	\sinepat,
	Pbind(
		\instrument, \sine,
		\dur, Pwhite(0.05, 0.5, inf),
		\midinote, Pseq([30],inf).trace,
		\harmonic, Pexprand(1, 40, inf).round, //can cut out some of the higher partials
		\atk, Pwhite(2.0, 3.0, inf),
		\rel, Pwhite(5.0, 10.0, inf),
		// amplitude relying on the other harmonic pattern,
		\amp, Pkey(\harmonic).reciprocal * 0.3,
		\pan, Pwhite(-0.8, 0.8, inf),
	);
).play;
)

//turn the attetnion to rythm
// change the sound source from sine wayves to buffers
(
d = Dictionary.new;
d.add(\l ->
	PathName("Users/Andreia Matos/Desktop/soundSamples/fingerSlideGuitar.wav").entries.collect({
		arg sf;
		Buffer.read(s, sf.fullPath);
	});
);
)

(
d = Dictionary.new;
d.add(\m ->
	PathName("C:/Users/Andreia Matos/Desktop/soundSamples/rotatoryDial.wav").entries.collect({
		arg sf;
		Buffer.read(s, sf.fullPath);
	});
);
)
(
d = Dictionary.new;
d.add(\h ->
	PathName("C:/Users/Andreia Matos/Desktop/soundSamples/heartbeat.wav").entries.collect({
		arg sf;
		Buffer.read(s, sf.fullPath);
	});
);
)


d[\l].choose.play;
// we can nest patterns inside of one another!!!
//END + REVISIT




/* TUTORIAL 20 MICROPHONES + SOUNDIN*/

s.boot;

s.meter;

ServerOptions.devices;

//to specify name of in and out device
(
s.option.inDevice = "Headset Microphone (Realtek(R)";
s.option.outDevice = "Speaker (Realtek(R) Audio)";
)

// !2 same as [0,0] to make sound go left and right, multichannel
(
x = {
	var sig, rmod;
	sig = SoundIn.ar(0!2);
	rmod = sig * SinOsc.ar(700);
	(sig + rmod) * 0.25;
}.play;
)

x.free;

(
x = {
	var sig;
	sig = SoundIn.ar(2!2);
	//Out.ar(0, sig); playa already does this
}.play;
)


(
SynthDef.new(\mic, {
	arg in = 0, out = 0, amp = 1;
	var sig;
	sig = SoundIn.ar(in!2) * amp;
	Out.ar(out, sig);
}).add;
)

x = Synth(\mic);

//delay effect

(
SynthDef.new(\mic, {
	arg in = 0, out = 0, deltime = 0.3, mix = (-0.5), amp = 1;
	var sig, delay;
	sig = SoundIn.ar(in!2) * amp;
	delay = DelayL.ar(sig, 0.5, deltime);
	// better mix than just add as we did in the rind modulation example
	sig =XFade2.ar(sig, delay, mix);
	Out.ar(out, sig);
}).add;
)

//delay that feeds back into itself effect, decay in seconds
// more realistic eco effect
(
SynthDef.new(\delay, {
	arg in = 0, out = 0, deltime = 0.3, mix = (-0.5), decay = 3, amp = 1;
	var sig, delay;
	sig = SoundIn.ar(in!2) * amp;
	delay = CombL.ar(sig, 0.5, deltime, decay);
	// better mix than just add as we did in the rind modulation example
	sig =XFade2.ar(sig, delay, mix);
	Out.ar(out, sig);
}).add;
)


//sin wave for delay time, flunctuating
(
SynthDef.new(\delay, {
	arg in = 0, out = 0, deltime = 0.3, mix = (-0.5), decay = 3, amp = 1, delHz = 0.25, delMin = 0.1, delMax = 0.4;
	var sig, delay;
	sig = SoundIn.ar(in!2) * amp;
	//[0.32, 0.3] for different between the 2 ears, just (0,3) for same
	delay = CombL.ar(
		sig,
		0.5,
		SinOsc.kr([delHz, delHz*0.9]).exprange(delMin, delMax), decay);
	// better mix than just add as we did in the rind modulation example
	sig =XFade2.ar(sig, delay, mix);
	Out.ar(out, sig);
}).add;
)

// good idea to modularize so that it doesnt all spiral out of control

x = Synth(\delay);

//bc we split the work into 2 synth defs we need to alocate a 2 channel private bus
~delBus = Bus.audio(s,2);

//groups to manage the order of  more cleanly
(
~micGrp = Group.new;
~delGrp = Group.after(~micGrp);

~micSynth = Synth(\mic, [\in, 0, \out, ~delBus], ~micGrp);
~delGrp = Synth(\delay, [\in, ~delBus, \out, 0], ~delGrp);

)

s.freeAll;

//now we have a lot more flexibility

(
~micGrp = Group.new;
~delGrp = Group.after(~micGrp);

~micSynthDirect = Synth(\mic, [\in, 0, \out, 0], ~micGrp);
~micSynthEffect = Synth(\mic, [\in, 0, \out, ~delBus], ~delGrp);

20.do({
	Synth(\delay, [
		\in, ~delBus,
		\out, 0,
		\mix, 1,
		\amp, 1/20,
		\delHz, exprand(0.02, 0, 0.08),
		\delMin, exprand(0.05, 0.1),
		\delMax, exprand(0.101, 0.2), //dont surpass the delay of 0.5 sec
		\decay, rrand(3.0, 6.0),
	], ~delGrp);
});
)

s.freeAll;
// add envelope to fade it better....

