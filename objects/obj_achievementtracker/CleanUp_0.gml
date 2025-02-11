if PATCHED_MEMORY_LEAKS
{
	ds_map_destroy(global.steam_achievements);
	ds_queue_destroy(notify_queue);
	ds_queue_destroy(unlock_queue);
}
