global.holiday = holiday.none;
global.longintro = true;

function scr_startup_preload()
{
	pal_swap_init_system_fix(shd_pal_swapper);
	
	global.longintro = true;
	tdp_text_init();

	global.holiday = holiday.none;
	var date = date_current_datetime();
	var month = date_get_month(date);
	var day = date_get_day(date);
	if month == 10 || (month == 11 && day <= 14)
		global.holiday = holiday.halloween;
}
