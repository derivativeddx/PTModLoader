if PATCHED_FMOD_LEAKS
{
	if self[$ "chargesnd"] != undefined
		destroy_sounds([chargesnd]);
}
