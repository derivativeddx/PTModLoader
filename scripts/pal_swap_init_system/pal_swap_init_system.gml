function pal_swap_init_system()
{
	// do nothing
}

function pal_swap_init_system_fix(shader, enable_map)
{
	global.Pal_Shader = shader;
	global.Pal_Texel_Size = shader_get_uniform(shader, "texel_size");
	global.Pal_UVs = shader_get_uniform(shader, "palette_UVs");
	global.Pal_Index = shader_get_uniform(shader, "palette_index");
	global.Pal_Texture = shader_get_sampler_index(shader, "palette_texture");
	
	if enable_map
	{
		if PATCHED_MEMORY_LEAKS
		{
			if ds_exists(global[$ "Pal_Map"], ds_type_map)
				ds_map_destroy(global.Pal_Map);
		}
		global.Pal_Map = ds_map_create();
	}
	
	global.Pattern_Texture_Indexed = noone;
	global.Base_Pattern_Color = [1, 2];
	
	global.Pattern_Texture = shader_get_sampler_index(shader, "pattern_texture");
	global.Pattern_Enable = shader_get_uniform(shader, "pattern_enabled");
	global.Pattern_Tex_Data = shader_get_uniform(shader, "pattern_tex_data");
	global.Pattern_UVs = shader_get_uniform(shader, "pattern_UVs");
	global.Pattern_Spr_UVs = shader_get_uniform(shader, "sprite_UVs");
	global.Pattern_Spr_Tex_Data = shader_get_uniform(shader, "sprite_tex_data");
	global.Pattern_Spr_Scale = shader_get_uniform(shader, "sprite_scale");
	global.Pattern_Color_Array = shader_get_uniform(shader, "color_array");
	global.Pattern_Solid_Color = shader_get_uniform(shader, "pattern_solid_color");
}

global.N_Pal_Texture = shader_get_sampler_index(shd_noise_afterimage, "palette_texture");
global.N_Texel_Size = shader_get_uniform(shd_noise_afterimage, "texel_size");
global.N_Pal_UVs = shader_get_uniform(shd_noise_afterimage, "palette_UVs");
global.N_Pal_Index = shader_get_uniform(shd_noise_afterimage, "palette_index");
global.N_Pal_Y = shader_get_uniform(shd_noise_afterimage, "palette_y");
global.N_Pattern_Tex = shader_get_sampler_index(shd_noise_afterimage, "pattern_texture");
global.N_Pattern_Enabled = shader_get_uniform(shd_noise_afterimage, "pattern_enabled");
global.N_Pattern_UVs = shader_get_uniform(shd_noise_afterimage, "pattern_UVs");
