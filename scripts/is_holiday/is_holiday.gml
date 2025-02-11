enum holiday
{
	none,
	halloween
}

function is_holiday(holiday)
{
	if global.holiday != holiday
		return false;
	for (var i = 0; i < 3; i++)
	{
		if global.game[i].judgement != "none" || global.gameN[i].judgement != "none"
			return true;
	}
	return false;
}
