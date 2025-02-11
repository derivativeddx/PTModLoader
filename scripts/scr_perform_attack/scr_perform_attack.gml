function scr_perform_attack(required_state)
{
	if required_state == states.mach3 && sprite_index == spr_dashpadmach
		exit;
	if required_state == states.mach2 && skateboarding
		exit;
	
	if required_state == states.normal
		scr_perform_shoot(required_state);
	
	if input_buffer_slap > 0 && !key_up && !shotgunAnim && !global.pistol && !(state == states.jump && sprite_index == spr_suplexbump)
		scr_modmove_grab(required_state);
	else if input_buffer_slap > 0 && key_up && !shotgunAnim && (!global.pistol || !ispeppino)
		scr_modmove_uppercut(required_state);
	
	if required_state != states.normal
		scr_perform_shoot(required_state);
}
function scr_perform_shoot(required_state)
{
	if input_buffer_shoot > 0
	{
		if shotgunAnim
			scr_shotgunshoot();
		else if global.pistol
			scr_pistolshoot(required_state);
	}
}
