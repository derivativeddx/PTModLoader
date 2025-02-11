function scr_modmove_grab(required_state)
{
	input_buffer_slap = 0;
	sprite_index = required_state == states.jump ? spr_suplexdashjumpstart : spr_suplexdash;
	suplexmove = true;
	particle_set_scale(particle.jumpdust, xscale, 1);
	create_particle(x, y, particle.jumpdust, 0);
	fmod_event_instance_play(suplexdashsnd);
	state = states.handstandjump;
	if required_state == states.normal
		movespeed = 8;
	else if movespeed < 5 or required_state == states.jump
		movespeed = 5;
	image_index = 0;
}
