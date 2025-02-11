function instance_is_pausable(instance)
{
	static unpausable = [
		obj_eventorder, obj_inputAssigner, obj_savesystem,
		obj_pause, obj_screensizer, obj_music, obj_fmod, obj_globaltimer
	];
	return !array_contains(unpausable, instance.object_index);
}
