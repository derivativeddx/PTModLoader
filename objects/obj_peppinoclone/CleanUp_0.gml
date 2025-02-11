if PATCHED_FMOD_LEAKS
	destroy_sounds([snd]);
else
	fmod_event_instance_stop(snd);
