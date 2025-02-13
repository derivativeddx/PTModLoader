#macro lstr lang_get_value_newline
#macro lspr lang_get_sprite
#macro lfnt lang_get_font

function scr_get_languages()
{
	global.lang_map = ds_map_create();
	global.lang_sprite_map = ds_map_create();
	global.lang_texture_map = ds_map_create();
	global.lang_to_load = ds_queue_create();
	global.lang_available = ds_map_create();
	global.lang_loaded = ds_list_create();
	global.lang_tex_max = 0;
	
	if !variable_global_exists("lang")
		global.lang = "en";
	
	var arr = [];
	for (var def = file_find_first("lang/*.def", 0); def != ""; def = file_find_next())
		array_push(arr, def);
	file_find_close();
	
	for (var i = 0; i < array_length(arr); i++)
    {
	    var str = scr_lang_get_file_arr("lang/" + arr[i])
	    global.lang_available[? str[0]] = {
	        name: str[1],
	        file: str[2]
	    };
	}
	
	global.credits_arr = scr_lang_get_credits();
	global.noisecredits_arr = scr_lang_get_noise_credits();
	global.lang_textures_to_load = ds_list_create();
	ds_list_add(global.lang_loaded, "en");
	lang_parse_file("english.txt");
	
	global.font_map = ds_map_create();
	ds_map_set(global.font_map, "bigfont_en", global.bigfont);
	ds_map_set(global.font_map, "smallfont_en", global.smallfont);
	ds_map_set(global.font_map, "tutorialfont_en", global.tutorialfont);
	ds_map_set(global.font_map, "creditsfont_en", global.creditsfont);
	ds_map_set(global.font_map, "captionfont_en", fnt_caption);

	font_add_enable_aa(false);
	var key = ds_map_find_first(global.lang_map);
	for (var i = 0; i < ds_map_size(global.lang_map); i++)
	{
		var lang = ds_map_find_value(global.lang_map, key);
		lang_load_fonts(key);
		key = ds_map_find_next(global.lang_map, key);
	}
}

function lang_read_file(filename)
{
	var fo = file_text_open_read("lang/" + filename);
	var str = "";
	while !file_text_eof(fo)
	{
		str += file_text_readln(fo);
		str += "\n";
	}
	file_text_close(fo);
	return str;
}

function lang_parse_file(filename)
{
	var str = lang_read_file(filename);
	var key = lang_parse(str);
	if lang_get_value_raw(key, "custom_graphics")
		lang_sprites_parse(key);
}

function scr_lang_get_file_arr(filename)
{
	var fo = file_text_open_read(filename);
	var arr = array_create(0);
	while !file_text_eof(fo)
	{
		array_push(arr, file_text_read_string(fo));
		file_text_readln(fo);
	}
	file_text_close(fo);
	return arr;
}

function scr_lang_get_credits()
{
	return scr_lang_get_file_arr("credits.txt");
}

function scr_lang_get_noise_credits()
{
	var arr = scr_lang_get_file_arr("noisecredits.txt");
	var credits = array_create(0);
	for (var i = 0; i < array_length(arr); i++)
	{
		var _name = arr[i++];
		var _heads = array_create(0);
		for (var _head = arr[i++]; _head != ""; _head = arr[i++])
		{
			array_push(_heads, real(_head) - 1);
			if i >= array_length(arr)
				break;
		}
		i--;
		array_push(credits, 
		{
			name: _name,
			heads: _heads
		});
	}
	return credits;
}

function lang_get_value_raw(lang, entry)
{
	var result = undefined;
	
	for(var i = 0, n = array_length(global.mods); i < n; ++i)
	{
		var this_mod = global.mods[i];
		if !this_mod.enabled
			continue;
		
		if is_undefined(result) && !is_undefined(this_mod.lang_map[? lang])
			result = this_mod.lang_map[? lang][? entry];
		
		if is_undefined(result) && !is_undefined(this_mod.lang_map[? "en"])
			result = this_mod.lang_map[? "en"][? entry];
		
		if !is_undefined(result)
			return result;
	}
	
	if is_undefined(result)
		result = ds_map_find_value(ds_map_find_value(global.lang_map, lang), entry);
	
	if is_undefined(result)
		result = ds_map_find_value(ds_map_find_value(global.lang_map, "en"), entry);
		
	if is_undefined(result)
	{
		result = "";
		lang_error(concat("Error: Could not find lang value \"", entry, "\"\n", global.processing_mod != noone ? $"Caused by {global.processing_mod.name}" : "Please restore your english.txt file"));
	}
	
	return result;
}

function lang_get_value(entry)
{
	return lang_get_value_raw(global.lang, entry);
}

function lang_get_value_newline(entry)
{
	return string_replace_all(lang_get_value(entry), "\\n", "\n");
}

function lang_get_value_newline_raw(lang, entry)
{
	return string_replace_all(lang_get_value_raw(lang, entry), "\\n", "\n");
}

function lang_parse(langstring) // langstring being the entire file in a single string
{
	var list = ds_list_create();
	lang_lexer(list, langstring);
	var map = lang_exec(list);
	var lang = ds_map_find_value(map, "lang");
	ds_map_set(global.lang_map, lang, map);
	ds_list_destroy(list);
	return lang;
}

enum lang_tokens
{
	set,
	name,
	value,
	keyword,
	eof
}

function lang_lexer(list, str)
{
	var len = string_length(str);
	var pos = 1;
	while pos <= len
	{
		var start = pos;
		var char = string_ord_at(str, pos);
		pos += 1;
		
		switch char
		{
			case ord(" "):
			case ord("	"): // horizontal tab
			case ord("\r"): // carriage return
			case ord("\n"): // newline
				break;
			
			case ord("#"):
				while pos <= len
				{
					char = string_ord_at(str, pos);
					if char == ord("\r") || char == ord("\n")
						break;
					pos += 1;
				}
				break;
			
			case ord("="):
				ds_list_add(list, [lang_tokens.set, start]);
				break;
			
			case ord("\""):
				while pos <= len
				{
					char = string_ord_at(str, pos);
					if char != ord("\"") || string_ord_at(str, pos - 1) == ord("\\")
						pos += 1;
					else
						break;
				}
				
				if pos <= len
				{
					var val = string_copy(str, start + 1, pos - start - 1);
					if FIX_LANG_QUOTES
						val = string_replace_all(val, "\\\"", "\"");
					ds_list_add(list, [lang_tokens.value, start, val]);
					pos += 1;
				}
				else
					exit;
				
				break;
			
			default:
				if lang_get_identifier(char, false)
				{
					while pos <= len
					{
						char = string_ord_at(str, pos);
						if lang_get_identifier(char, true)
							pos += 1;
						else
							break;
					}
					
					var name = string_copy(str, start, pos - start);
					switch name
					{
						case "false":
							ds_list_add(list, [lang_tokens.keyword, start, false]);
							break;
						case "noone":
							ds_list_add(list, [lang_tokens.keyword, start, noone]);
							break
						case "true":
							ds_list_add(list, [lang_tokens.keyword, start, true]);
							break;
						default:
							ds_list_add(list, [lang_tokens.name, start, name]);
					}
				}
				break;
		}
	}
	ds_list_add(list, [lang_tokens.eof, len + 1]);
}

function lang_get_identifier(keycode, allow_numbers)
{
	if allow_numbers
		return keycode == ord("_") || (keycode >= ord("a") && keycode <= ord("z")) || (keycode >= ord("A") && keycode <= ord("Z")) || (keycode >= ord("0") && keycode <= ord("9"));
	else
		return keycode == ord("_") || (keycode >= ord("a") && keycode <= ord("z")) || (keycode >= ord("A") && keycode <= ord("Z"));
}

function lang_exec(token_list) // Man.
{
	var map = ds_map_create();
	var len = ds_list_size(token_list);
	
	var pos = 0;
	while pos < len
	{
		var q = ds_list_find_value(token_list, pos++);
		switch q[0]
		{
			case lang_tokens.set:
				var ident = token_list[| pos - 2][2];
				var val = token_list[| pos++][2];
				ds_map_set(map, ident, val);
				break;
		}
	}
	return map;
}

function lang_get_custom_font(fontname, language)
{
	var _dir = concat(fontname, "_dir");
	var _ttf = ds_map_find_value(language, "use_ttf");
	if !is_undefined(_ttf) && _ttf
	{
		if !is_undefined(ds_map_find_value(language, _dir))
		{
			var font_size = ds_map_find_value(language, concat(fontname, "_size"));
			font_size = real(font_size);
			return font_add(concat("lang/", ds_map_find_value(language, _dir)), font_size, false, false, 32, 127);
		}
	}
	else if !is_undefined(ds_map_find_value(language, _dir))
	{
		var font_map = ds_map_find_value(language, concat(fontname, "_map"));
		var font_size = string_length(font_map);
		var font_sep = ds_map_find_value(language, concat(fontname, "_sep"));
		font_sep = real(font_sep);
		var font_xorig = 0;
		var font_yorig = 0;
		var spr = sprite_add(concat("lang/", ds_map_find_value(language, _dir)), font_size, false, false, font_xorig, font_yorig);
		return font_add_sprite_ext(spr, font_map, false, font_sep);
	}
	return lang_get_font(fontname);
}

function lang_get_font(fontname)
{
	var n = ds_map_find_value(global.font_map, lang_get_value(fontname));
	if !is_undefined(n)
		return n;
	return ds_map_find_value(global.font_map, concat(fontname, "_en"));
}
