if !lang_init
{
	lang_init = true;
	scr_lang_load_init();
}
else if !scr_lang_load_update()
{
	if array_length(tex_list) > 0
	{
		var tex = array_pop(tex_list);
		trace("Loading texture: ", tex);
		if !texture_is_ready(tex)
			texture_prefetch(tex);
		comment = "Loading textures";
	}
	else if array_length(mods_to_load) > 0
	{
		var m = array_shift(mods_to_load);
		scr_modding_load_mod(m);
		comment = "Loading mods";
	}
	else
	{
		scr_modding_init_mods();
		room_goto(Realtitlescreen);
		screen_apply_vsync();
	}
}
alarm[0] = 1;
