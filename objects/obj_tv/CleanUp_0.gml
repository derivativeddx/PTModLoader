if PATCHED_MEMORY_LEAKS
{
	ds_list_destroy(tvprompts_list);
	if surface_exists(promptsurface)
		surface_free(promptsurface);
	if surface_exists(bar_surface)
		surface_free(bar_surface);
}
