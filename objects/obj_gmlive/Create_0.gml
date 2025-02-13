#macro live_enabled 1
#macro live_update_enabled (live_enabled && (GM_build_type == "run"))

if live_enabled
{
	if instance_number(obj_gmlive) > 1
	{
		var first = instance_find(obj_gmlive, 0);
		if id != first
		{
			instance_destroy();
			exit;
		}
	}

	if live_update_enabled
	{
		if asset_get_index("live_init") == -1
			show_error("live_init is missing!\nEither GMLive is not imported in the project, or the 'GMLive' script got corrupted (try re-importing)\nIf you don't have GMLive, you can safely remove obj_gmlive and any remaining live_* function calls.\n\n", 1);
	}

	// change the IP/port here if gmlive-server isn't running on the same device as the game
	// (e.g. when running on mobile platforms):
	live_init(1, live_update_enabled ? "http://localhost:5100" : undefined, "");

	#region CONSTANTS

	for (var i = 0; sequence_exists(i); i++)
		gml_asset_add(sequence_get(i).name, i);

	#endregion
	
	scr_modding_init();
}
else
	instance_destroy();
