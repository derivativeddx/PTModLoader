if PATCHED_MEMORY_LEAKS
{
	if surface_exists(surface)
		surface_free(surface);
}
