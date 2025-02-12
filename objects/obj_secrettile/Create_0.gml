active = false;
alpha = 1;
depth = -7;
desireddepth = -6;
surf = noone;
tiles = [[], [], []];

for (var i = 0; i < 3; i++)
{
	var lay_id = layer_get_id(concat("Tiles_Secret", i + 1));
	tilemap_sprite[i] = noone;
	
	if lay_id != -1
	{
		var map_id = layer_tilemap_get_id(lay_id);
		tilemap_sprite[i] = tilemap_get_tileset(map_id);
		
		for (var yy = 0; yy < image_yscale; yy++)
		{
			for (var xx = 0; xx < image_xscale; xx++)
			{
				var _x = xx * 32, _y = yy * 32;
				var data = tilemap_get_at_pixel(map_id, x + _x, y + _y);
				array_push(tiles[i], [_x, _y, data]);
				data = tile_set_empty(data);
				tilemap_set_at_pixel(map_id, data, x + _x, y + _y);
			}
		}
	}
}

trace(tilemap_sprite);
if array_length(tiles[0]) <= 0 && array_length(tiles[1]) <= 0 && array_length(tiles[2]) <= 0
	instance_destroy();
