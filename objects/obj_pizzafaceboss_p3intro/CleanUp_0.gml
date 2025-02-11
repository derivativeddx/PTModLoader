if !PATCHED_FMOD_LEAKS
	destroy_sounds([snd_spin]);
else
	destroy_sounds([snd_spin, snd_laugh]);
