#macro instance_destroy_base instance_destroy
#macro instance_destroy instance_destroy_hook

function instance_destroy_hook(_id = self.id, execute_event_flag = true)
{
	with _id
	{
		if object_index == obj_gmlive
			exit;
		if execute_event_flag
			event_perform(ev_destroy, 0);
	}
	instance_destroy_base(_id, false);
}

#macro instance_create_depth_base instance_create_depth
#macro instance_create_depth instance_create_depth_hook

function instance_create_depth_hook(x, y, depth, obj, var_struct = {})
{
	if is_instanceof(obj, ModObject)
	{
		var m = global.processing_mod ?? noone;
		if m == noone return noone;
		var_struct.__OBJECT = obj;
		var o = instance_create_depth_base(x, y, depth, obj_mod_object, var_struct);
		global.processing_mod = m;
		return o;
	}
	else
	{
		if PATCHED_EVENT_ORDER && instance_exists(obj_eventorder)
		{
			// old gamemaker didn't run the step event of a recently created object
			var o = obj_eventorder, r = o[$ "order"];
			if r != undefined && array_contains(r, self[$ "object_index"]) && array_contains(r, obj)
				var_struct._order_buffer = 1;
		}
		return instance_create_depth_base(x, y, depth, obj, var_struct);
	}
}
