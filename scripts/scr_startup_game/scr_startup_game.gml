if PATCHED_MEMORY_LEAKS
{
	global.saveroom = ds_list_create();
	global.baddietomb = ds_list_create();
	global.smallnumber_fnt = font_add_sprite_ext(spr_smallnumber, "1234567890-+", true, 0);
}

global.escaperoom = ds_list_create();
global.instancelist = ds_list_create();
global.followerlist = ds_list_create();
global.baddieroom = ds_list_create();

function scr_startup_game()
{
	static create = function(x, y, o)
	{
		if instance_exists(o)
			return o;
		return instance_create(x, y, o);
	}
	
	create(576, 352, obj_player1);
	scr_startup_player();
	
	create(-160, 224, obj_player2);
	create(0, -64, obj_camera);
	create(32, -64, obj_inputAssigner);
	create(64, -64, obj_music);
	create(96, -64, obj_parrallax);
	create(128, -64, obj_particlesystem);
	create(160, -64, obj_pause);
	create(192, -64, obj_tv);
	create(224, -64, obj_saveroom);
	create(256, -64, obj_roomname);
	create(320, -64, obj_hardmode);
	create(352, -32, obj_baddietombcontroller);
	create(-96, 0, obj_timeattack);
	create(352, -64, obj_drawcontroller);
	create(384, -128, obj_afterimagecontroller);
	create(288, -96, obj_debugcontroller);
	create(0, -96, obj_stylebar);
	create(32, -96, obj_heatafterimage);
	create(64, -96, obj_chunktimer);
	create(288, -160, obj_secretmanager);
	create(224, -160, obj_achievementtracker);
	create(-128, 0, obj_globaltimer);
	create(800, -64, obj_consoledebug);
	
	global.coop = false;
	global.currentsavefile = 1;
	
	var achievement_arr = ["sranks1", "sranks2", "sranks3", "sranks4", "sranks5"];
	var data_arr = [get_save_folder() + "/saveData1", get_save_folder() + "/saveData2", get_save_folder() + "/saveData3"];
	for (var i = 0; i < array_length(data_arr); i++)
	{
		global.game[i] = scr_read_game(data_arr[i] + ".ini");
		global.gameN[i] = scr_read_game(data_arr[i] + "N.ini");
	}
	
	global.stickreq[0] = 100;
	global.stickreq[1] = 150;
	global.stickreq[2] = 200;
	global.stickreq[3] = 200;
	global.stickreq[4] = 210;
	global.levelattempts = 0;
	global.palette_arr = [false, false, false, false, false];
	global.newtoppin[0] = false;
	global.newtoppin[1] = false;
	global.newtoppin[2] = false;
	global.newtoppin[3] = false;
	global.newtoppin[4] = false;
	
	global.mach_color1 = make_colour_rgb(96, 208, 72);
	global.mach_color2 = make_colour_rgb(248, 0, 0);
	global.afterimage_color1 = make_colour_rgb(255, 0, 0);
	global.afterimage_color2 = make_colour_rgb(0, 255, 0);
	global.smallnumber_color1 = make_colour_rgb(255, 255, 255);
	global.smallnumber_color2 = make_colour_rgb(248, 0, 0);
	
	if !PATCHED_MEMORY_LEAKS
		global.smallnumber_fnt = font_add_sprite_ext(spr_smallnumber, "1234567890-+", true, 0);
	
	global.optimize = false;
	global.autotile = true;
	global.pigreduction = 0;
	global.pigtotal = 0;
	
	#region SEPTEMBER
	
	global.levelcomplete = false;
	global.levelcompletename = noone;
	global.entrancetreasure = false;
	global.medievaltreasure = false;
	global.ruintreasure = false;
	global.dungeontreasure = false;
	global.deserttreasure = false;
	global.graveyardtreasure = false;
	global.farmtreasure = false;
	global.spacetreasure = false;
	global.beachtreasure = false;
	global.foresttreasure = false;
	global.pinballtreasure = false;
	global.golftreasure = false;
	global.streettreasure = false;
	global.sewertreasure = false;
	global.factorytreasure = false;
	global.freezertreasure = false;
	global.chateautreasure = false;
	global.mansiontreasure = false;
	global.kidspartytreasure = false;
	global.wartreasure = false;
	global.entrancecutscene = noone;
	global.medievalcutscene = noone;
	global.ruincutscene = noone;
	global.ruincutscene2 = noone;
	global.ruincutscene3 = noone;
	global.dungeoncutscene = noone;
	global.peppermancutscene1 = noone;
	global.peppermancutscene2 = noone;
	global.chieftaincutscene = noone;
	global.chieftaincutscene2 = noone;
	global.desertcutscene = noone;
	global.graveyardcutscene = noone;
	global.spacecutscene = noone;
	global.vigilantecutscene1 = noone;
	global.vigilantecutscene2 = noone;
	global.vigilantecutscene3 = noone;
	global.farmcutscene = noone;
	global.superpinballcutscene = noone;
	global.pubcutscene = noone;
	global.pinballcutscene = noone;
	global.beercutscene = noone;
	global.exitfeecutscene = noone;
	global.forestcutscene = noone;
	global.bottlecutscene = noone;
	global.papercutscene = noone;
	global.beachboatcutscene = noone;
	global.beachcutscene = noone;
	global.sewercutscene = noone;
	global.burgercutscene = noone;
	global.golfcutscene = noone;
	global.anarchistcutscene1 = noone;
	global.anarchistcutscene2 = noone;
	global.factoryblock = noone;
	global.streetcutscene = noone;
	global.graffiticutscene = noone;
	global.factorygraffiti = noone;
	global.factorycutscene = noone;
	global.hatcutscene1 = noone;
	global.hatcutscene2 = noone;
	global.hatcutscene3 = noone;
	global.jetpackcutscene = noone;
	global.noisecutscene1 = noone;
	global.noisecutscene2 = noone;
	global.freezercutscene = noone;
	global.kidspartycutscene = noone;
	global.gasolinecutscene = noone;
	global.mansioncutscene = noone;
	global.chateaucutscene = noone;
	global.ghostsoldiercutscene = noone;
	global.mrstickcutscene1 = noone;
	global.mrstickcutscene2 = noone;
	global.mrstickcutscene3 = noone;
	global.chateauswap = noone;
	global.warcutscene = noone;
	
	#endregion
	
	with obj_player1
		state = states.normal;
	global.loadeditor = false;
	if global.longintro
	{
		global.longintro = false;
		room_goto(Longintro);
	}
	else
		room_goto(Mainmenu);
	instance_destroy(obj_cutscene_handler);
}

function scr_startup_player()
{
	global.combodropped = false;
	global.lap = false;
	global.laps = 0;
	global.playerhealth = 100;
	global.maxrailspeed = 2;
	global.railspeed = global.maxrailspeed;
	global.levelreset = false;
	global.temperature = 0;
	global.temperature_spd = 0.01;
	global.temp_thresholdnumber = 5;
	global.use_temperature = false;
	global.timedgatetimer = false;
	global.timedgatetime = 0;
	global.timedgateid = -4;
	global.timedgatetimemax = 0;
	global.key_inv = false;
	global.shroomfollow = false;
	global.cheesefollow = false;
	global.tomatofollow = false;
	global.sausagefollow = false;
	global.pineapplefollow = false;
	global.pepanimatronic = false;
	global.keyget = false;
	global.collect = 0;
	global.lastcollect = 0;
	global.collectN = 0;
	global.collect_player[0] = 0;
	global.collect_player[1] = 0;
	global.hats = 0;
	global.extrahats = 0;
	global.treasure = false;
	global.combo = 0;
	global.previouscombo = 0;
	global.combotime = 0;
	global.combotimepause = 0;
	global.prank_enemykilled = false;
	global.prank_cankillenemy = true;
	global.tauntcount = 0;
	global.comboscore = 0;
	global.savedcomboscore = 0;
	global.savedcombo = 0;
	global.heattime = 0;
	global.pizzacoin = 0;
	global.toppintotal = 1;
	global.hit = 0;
	global.hp = 2;
	global.gotshotgun = false;
	global.showgnomelist = true;
	global.panic = false;
	global.snickchallenge = false;
	global.golfhit = 0;
	global.style = -1;
	global.secretfound = 0;
	global.shotgunammo = 0;
	global.monsterspeed = 0;
	global.monsterlives = 3;
	global.giantkey = false;
	global.coop = false;
	global.baddiespeed = 1;
	global.baddiepowerup = false;
	global.baddierage = false;
	global.style = 0;
	global.stylethreshold = 0;
	global.pizzadelivery = false;
	global.failcutscene = false;
	global.pizzasdelivered = 0;
	global.spaceblockswitch = true;
	global.gerome = false;
	global.pigtotal_add = 0;
	global.bullet = 0;
	global.fuel = 3;
	global.ammorefill = 0;
	global.ammoalt = 1;
	global.mort = false;
	global.stylelock = false;
	global.attackstyle = 0;
	global.pummeltest = true;
	global.horse = false;
	global.checkpoint_room = -4;
	global.checkpoint_door = "A";
	global.kungfu = false;
	global.graffiticount = 0;
	global.graffitimax = 20;
	global.noisejetpack = false;
	global.hasfarmer = array_create(3, false);
	global.savedattackstyle = -4;
	
	global.throw_frame = [];
	global.throw_frame[obj_pizzagoblin] = 11;
	global.throw_frame[obj_canongoblin] = 13;
	global.throw_frame[obj_noisegoblin] = 18;
	global.throw_frame[obj_cheeserobot] = 6;
	global.throw_frame[obj_spitcheese] = 2;
	global.throw_frame[obj_bazookabaddie] = 7;
	global.throw_frame[obj_trash] = 2;
	global.throw_frame[obj_invtrash] = 2;
	global.throw_frame[obj_robot] = 2;
	global.throw_frame[obj_kentukykenny] = 8;
	global.throw_frame[obj_kentukylenny] = 8;
	global.throw_frame[obj_pizzard] = 6;
	global.throw_frame[obj_pepgoblin] = 3;
	global.throw_frame[obj_pepbat] = 8;
	global.throw_frame[obj_swedishmonkey] = 15;
	global.throw_frame[obj_rancher] = 10;
	global.throw_frame[obj_pickle] = 2;
	global.throw_frame[obj_tank] = 6;
	global.throw_frame[obj_thug_blue] = 9;
	global.throw_frame[obj_thug_green] = 9;
	global.throw_frame[obj_thug_red] = 9;
	global.throw_frame[obj_smokingpizzaslice] = 13;
	global.throw_frame[obj_miniufo] = 3;
	global.throw_frame[obj_kentukybomber] = 7;
	global.throw_frame[obj_miniufo_grounded] = 11;
	global.throw_frame[obj_farmerbaddie2] = 13;
	global.throw_frame[obj_farmerbaddie3] = 13;
	
	global.throw_sprite = [];
	global.throw_sprite[obj_pizzagoblin] = spr_pizzagoblin_throwbomb;
	global.throw_sprite[obj_canongoblin] = spr_canongoblin_throwbomb;
	global.throw_sprite[obj_noisegoblin] = spr_archergoblin_shoot;
	global.throw_sprite[obj_cheeserobot] = spr_cheeserobot_attack;
	global.throw_sprite[obj_spitcheese] = spr_spitcheese_spit;
	global.throw_sprite[obj_bazookabaddie] = spr_tank_shoot;
	global.throw_sprite[obj_trash] = spr_trash_throw;
	global.throw_sprite[obj_invtrash] = spr_invtrash_throw;
	global.throw_sprite[obj_robot] = spr_robot_attack;
	global.throw_sprite[obj_kentukykenny] = spr_kentukykenny_throw;
	global.throw_sprite[obj_kentukylenny] = spr_kentukykenny_throw;
	global.throw_sprite[obj_pizzard] = spr_pizzard_shoot;
	global.throw_sprite[obj_pepgoblin] = spr_pepgoblin_kick;
	global.throw_sprite[obj_pepbat] = spr_pepbat_kick;
	global.throw_sprite[obj_swedishmonkey] = spr_swedishmonkey_eat;
	global.throw_sprite[obj_rancher] = spr_ranch_shoot;
	global.throw_sprite[obj_pickle] = spr_pickle_attack;
	global.throw_sprite[obj_tank] = spr_tank_shoot;
	global.throw_sprite[obj_thug_blue] = spr_shrimp_knife;
	global.throw_sprite[obj_thug_green] = spr_shrimp_knife;
	global.throw_sprite[obj_thug_red] = spr_shrimp_knife;
	global.throw_sprite[obj_smokingpizzaslice] = spr_pizzaslug_cough;
	global.throw_sprite[obj_miniufo] = spr_ufolive_shoot;
	global.throw_sprite[obj_kentukybomber] = spr_kentukybomber_attack;
	global.throw_sprite[obj_miniufo_grounded] = spr_ufogrounded_shoot;
	global.throw_sprite[obj_farmerbaddie2] = spr_farmer2_throw;
	global.throw_sprite[obj_farmerbaddie3] = spr_peasanto_throw;
	
	global.reset_timer = [];
	global.reset_timer[obj_pizzagoblin] = 200;
	global.reset_timer[obj_canongoblin] = 200;
	global.reset_timer[obj_noisegoblin] = 200;
	global.reset_timer[obj_cheeserobot] = 200;
	global.reset_timer[obj_spitcheese] = 100;
	global.reset_timer[obj_bazookabaddie] = 400;
	global.reset_timer[obj_trash] = 100;
	global.reset_timer[obj_invtrash] = 100;
	global.reset_timer[obj_robot] = 150;
	global.reset_timer[obj_kentukykenny] = 200;
	global.reset_timer[obj_kentukylenny] = 200;
	global.reset_timer[obj_pizzard] = 100;
	global.reset_timer[obj_pepgoblin] = 200;
	global.reset_timer[obj_pepbat] = 200;
	global.reset_timer[obj_swedishmonkey] = 200;
	global.reset_timer[obj_rancher] = 100;
	global.reset_timer[obj_pickle] = 200;
	global.reset_timer[obj_tank] = 100;
	global.reset_timer[obj_thug_blue] = 60;
	global.reset_timer[obj_thug_green] = 60;
	global.reset_timer[obj_thug_red] = 60;
	global.reset_timer[obj_smokingpizzaslice] = 10;
	global.reset_timer[obj_miniufo] = 100;
	global.reset_timer[obj_kentukybomber] = 100;
	global.reset_timer[obj_miniufo_grounded] = 100;
	global.reset_timer[obj_farmerbaddie2] = 100;
	global.reset_timer[obj_farmerbaddie3] = 100;
}
