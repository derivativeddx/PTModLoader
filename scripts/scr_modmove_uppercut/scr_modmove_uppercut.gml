function scr_modmove_uppercut(required_state)
{
	state = states.punch;
	input_buffer_slap = 0;
	image_index = 0;
	sprite_index = spr_breakdanceuppercut;
	fmod_event_instance_play(snd_uppercut);
	
	if ispeppino
		vsp = required_state == states.normal ? -14 : -10;
	else
		vsp = required_state == states.normal ? -20 : -21;
	
	movespeed = hsp;
	
	// high jump going left
	if key_attack && (required_state == states.normal or required_state == states.jump)
		movespeed = abs(hsp);
	
	// particle
	particle_set_scale(particle.highjumpcloud2, xscale, 1);
	create_particle(x, y, particle.highjumpcloud2, 0);
	
	if !ispeppino
	{
		repeat 4
		{
			with instance_create(x + irandom_range(-40, 40), y + irandom_range(-40, 40), obj_explosioneffect)
			{
				sprite_index = spr_shineeffect;
				image_speed = 0.35;
			}
		}
	}
}
