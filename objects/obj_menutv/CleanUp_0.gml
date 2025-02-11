if surface_exists(surface)
	surface_free(surface);
if PATCHED_FMOD_LEAKS
	destroy_sounds([staticsnd]);
