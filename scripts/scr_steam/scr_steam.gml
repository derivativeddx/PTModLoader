function steam_utils_is_steam_running_on_steam_deck()
{
    return string_pos("AMD Custom GPU 0405", json_encode(os_get_info())) != 0;
}
function steam_get_achievement(achievement)
{
    return false;
}
function steam_set_achievement(achievement)
{
    
}
function steam_update()
{
    
}
function steam_initialised()
{
    return false;
}
function steam_stats_ready()
{
    return false;
}
function steam_is_screenshot_requested()
{
    return false;
}
function steam_send_screenshot(filename, width, height)
{
    
}
