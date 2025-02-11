if !PATCHED_FMOD_LEAKS
{
	if destroy
		destroy_sounds([snd]);
}
event_inherited();
