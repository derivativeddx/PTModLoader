event_inherited();
if !PATCHED_FMOD_LEAKS
{
	if ds_list_find_index(global.baddieroom, id) != -1
		destroy_sounds([snd]);
}
