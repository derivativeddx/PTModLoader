if PATCHED_MEMORY_LEAKS
	ds_map_destroy(music_map);
if PATCHED_FMOD_LEAKS
	destroy_sounds([pillarmusicID, panicmusicP, panicmusicN, kidspartychaseID]);
