if PATCHED_MEMORY_LEAKS
{
	if surface_exists(surf)
		surface_free(surf);
	if surface_exists(surf2)
		surface_free(surf2);
}
