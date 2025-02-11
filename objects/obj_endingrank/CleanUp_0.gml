destroy_sounds([snd_start, snd_verdict, snd_drumroll]);
if PATCHED_FMOD_LEAKS
{
	if snd != noone
		destroy_sounds([snd]);
	destroy_sounds([music]);
}
