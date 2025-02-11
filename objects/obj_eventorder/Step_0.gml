for(var i = 0; i < array_length(order); i++)
{
	with order[i]
		event_perform(ev_step, ev_step_normal);
}
