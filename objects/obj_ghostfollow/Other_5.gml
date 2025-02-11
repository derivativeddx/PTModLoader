if object_index == obj_halloweenfollow && state == states.johnghost
{
	with obj_player1
	{
		state = states.normal;
		landAnim = false;
		facehurt = true;
	}
}
if !PATCHED_FMOD_LEAKS
	destroy_sounds([snd]);
