with instance_create(x, y, obj_sausageman_dead)
{
	sprite_index = spr_johnecheese_dead;
	image_alpha = 0.5;
}
with obj_johnecheese_spawner
	alarm[0] = spawnmax;

if BASE_TRACES
	trace(snd);
