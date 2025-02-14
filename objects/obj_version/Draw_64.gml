draw_set_font(global.smallfont);
draw_set_align(fa_right, fa_bottom);
var a = 0;
with obj_mainmenu
	a = extrauialpha;
draw_text_color(SCREEN_WIDTH - 8, SCREEN_HEIGHT - 8, concat(lstr("mod_version"), "\n", lstr("base_prefix"), lstr("game_version")), c_white, c_white, c_white, c_white, a);
