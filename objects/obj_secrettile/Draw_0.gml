if !bbox_in_camera(view_camera[0], 32)
	exit;

if array_length(tiles) > 0
{
	if !surface_exists(surf)
	{
		var w = sprite_width, h = sprite_height;
		surf = surface_create(w, h);
		surface_set_target(surf);
		draw_clear_alpha(c_black, 0);
		for (var k = 0; k < array_length(tilemap_sprite); k++)
		{
			if tilemap_sprite[k] != noone
			{
				for (var i = 0; i < array_length(tiles[k]); i++)
				{
					var tile = tiles[k][i];
					draw_tile(tilemap_sprite[k], tile[2], 0, tile[0], tile[1]);
				}
			}
		}
		surface_reset_target();
	}
	draw_surface_ext(surf, x, y, 1, 1, 0, c_white, alpha);
}
