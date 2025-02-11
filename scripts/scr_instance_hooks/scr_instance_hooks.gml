#macro instance_create_depth_base instance_create_depth
#macro instance_create_depth instance_create_depth_hook

function instance_create_depth_hook(x, y, depth, obj, var_struct = {})
{
	if PATCHED_EVENT_ORDER var_struct._order_buffer = 1;
	return instance_create_depth_base(x, y, depth, obj, var_struct);
}
