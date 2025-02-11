if !PATCHED_FMOD_LEAKS
{
	if elitehit <= 0 && destroyable
		destroy_sounds([tacklesnd, mach2snd]);
}
event_inherited();
