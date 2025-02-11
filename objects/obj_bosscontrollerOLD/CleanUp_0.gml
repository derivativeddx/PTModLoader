if PATCHED_MEMORY_LEAKS
{
	if surface_exists(bar_surface)
		surface_free(bar_surface);
}
