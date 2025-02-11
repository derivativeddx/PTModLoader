if PATCHED_MEMORY_LEAKS
	ds_list_clear(global.saveroom);
else
	global.saveroom = ds_list_create();
