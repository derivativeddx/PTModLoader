pal_swap_init_system(shd_pal_swapper);
instance_destroy(obj_pigtotal);
instance_destroy(obj_swapmodefollow);
gameframe_caption_text = lang_get_value("caption_mainmenu");
with all
	event_perform(ev_other, ev_room_start);
with instance_create(0, 0, obj_loadingscreen)
{
	group_arr = ["hudgroup", "baddiegroup", "levelstructuregroup", "menugroup"];
	offload_arr = ["introgroup"];
}
with obj_player
	state = states.titlescreen;
global.swapmode = false;
global.leveltorestart = noone;
global.leveltosave = noone;
global.startgate = false;
global.exitrank = false;
