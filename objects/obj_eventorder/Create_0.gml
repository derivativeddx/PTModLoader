#macro ensure_order if (PATCHED_EVENT_ORDER) { \
if ((!instance_exists(other) or other.object_index != obj_eventorder) \
or (self[$ "_order_buffer"] != undefined)) \
{ \
	if self[$ "_order_buffer"] != undefined then self[$ "_order_buffer"]--; \
	if self[$ "_order_buffer"] == 0 then self[$ "_order_buffer"] = undefined; \
	exit; \
} }

if !PATCHED_EVENT_ORDER
{
	instance_destroy();
	exit;
}

// using System.Linq; string[] list = {"obj_player", "obj_baddiecollisionbox", "obj_forkhitbox", "obj_camera", "obj_parrallax", "obj_pause", "obj_option", "obj_screenconfirm", "obj_chargeeffect", "obj_superslameffect", "obj_followcharacter", "obj_pizzaface", "obj_doornexthub", "obj_monstertrackingrooms", "obj_hardmode"}; var list2 = ""; foreach(var i in Data.GameObjects) {if (list.Contains(i.Name.Content)) list2 += $"{i.Name.Content},\n"; } list2

order = [
	// persistent goes first
	obj_hardmode,
	obj_player,
	obj_pause,
	obj_music,
	obj_camera,
	obj_parrallax,
	
	// not persistent
	obj_option,
	obj_followcharacter,
	obj_monstertrackingrooms,
	obj_baddiecollisionbox,
	obj_forkhitbox,
	obj_pizzaface,
	obj_doornexthub,
	obj_chargeeffect,
	obj_superslameffect,
	obj_screenconfirm,
];
