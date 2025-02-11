if PATCHED_MEMORY_LEAKS
{
	ds_map_destroy(pause_menu_map);
	ds_list_destroy(instance_list);
	ds_list_destroy(sound_list);
	ds_list_destroy(priest_list);
}
if PATCHED_FMOD_LEAKS
	destroy_sounds([pausemusic_original, pausemusic_halloween]);
