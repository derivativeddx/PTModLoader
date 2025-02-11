if PATCHED_MEMORY_LEAKS
	ds_list_clear(global.baddietomb);
else
	global.baddietomb = ds_list_create();
