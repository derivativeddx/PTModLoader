if !PATCHED_FMOD_LEAKS
{
	fmod_event_instance_stop(snd, true);
	fmod_event_instance_release(snd);
}
