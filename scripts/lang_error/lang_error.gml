function lang_error(str = "Error")
{
	instance_create_unique(0, 0, obj_langerror);
	with obj_langerror
	{
		array_push(text,
		{
			text: str,
			alpha: 5
		});
	}
}
