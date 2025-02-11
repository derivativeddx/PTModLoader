if PATCHED_FMOD_LEAKS
{
	fmod_event_instance_stop(snd, false);
	fmod_event_instance_release(snd);
}
