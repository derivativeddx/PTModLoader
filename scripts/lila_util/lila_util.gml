#region General

globalvar current_frame;
current_frame = 0;
time_source_start(time_source_create(time_source_game, 1, time_source_units_frames, function() { ++current_frame; }, [], -1));

function performance_push()
{
	/// @desc Pushes to the performance measurer.
	
	static array = [];
	
	array_push(array, get_timer());
}

function performance_trace()
{
	/// @desc Calculates performance_push().
	
	if array_length(performance_push.array) < 2
		show_error("performance_trace() needs at least two performance_push() calls before being used.", true);
	
	var t = array_shift(performance_push.array);
	
	show_debug_message("");
	
	while array_length(performance_push.array)
	{
		var b = t;
		t = array_shift(performance_push.array);
		show_debug_message($"{t - b} microseconds");
	}
	
	show_debug_message("");
}

#endregion

#region Drawing

function draw_set_align(halign = fa_left, valign = fa_top)
{
	/// @desc draw_set_halign() and draw_set_valign() combined.
	/// @arg {any} halign fa_left, fa_center or fa_right. Default is fa_left
	/// @arg {any} valign fa_top, fa_middle or fa_bottom. Default is fa_top
	
	draw_set_halign(halign);
	draw_set_valign(valign);
}
function draw_clear_screen(col)
{
	/// @desc Safe alternative to draw_clear(). Draws a rectangle across the current surface.
	/// @arg {colour} col The colour with which the screen will be cleared
	
	if surface_get_target() == application_surface
	{
		if event_type == ev_draw && (event_number == ev_draw_normal or event_number == ev_draw_begin or event_number == ev_draw_end)
			var wd = room_width, ht = room_height;
		else if event_type == ev_draw && (event_number == ev_gui or event_number == ev_gui_begin or event_number == ev_gui_end)
			var wd = display_get_gui_width(), ht = display_get_gui_height();
		else
			var wd = window_get_width(), ht = window_get_height();
	}
	else
		var wd = surface_get_width(surface_get_target()), ht = surface_get_height(surface_get_target());
	
	draw_rectangle_color(0, 0, wd - 1, ht - 1, col, col, col, col, false);
}
function draw_sprite_optional(sprite = sprite_index, subimg = -1, x = self.x, y = self.y, xscale = image_xscale, yscale = image_yscale, rot = image_angle, col = image_blend, alpha = image_alpha)
{
	/// @desc draw_sprite_ext(), but every argument is optional.
	
	if sprite_exists(sprite)
		draw_sprite_ext(sprite, subimg, x, y, xscale, yscale, rot, col, alpha);
}
function draw_set_flash(enable, col = c_white)
{
	/// @desc Uses GPU fog to make everything a solid color.
	/// @arg {colour} col The colour to use for the fog
	
	gpu_set_fog(enable, col, 0, 1);
}

#endregion

#region Clipping

function draw_set_bounds(x1, y1, x2, y2)
{
	/// @desc Sets a boundary rectangle for drawing. Anything outside of this rectangle will be clipped out.
	/// @arg {real} x1 Left corner
	/// @arg {real} y1 Top corner
	/// @arg {real} x2 Right corner
	/// @arg {real} y2 Bottom corner
	
	draw_clear_mask();
	draw_mask_start();
	var a = draw_get_alpha();
	draw_set_alpha(1);
	draw_rectangle(x1, y1, x2 - 1, y2 - 1, false);
	draw_set_alpha(a);
	draw_mask_end();
}
function draw_set_mask(sprite, subimg, x, y, inverse = false, alpha_threshold = 0.5)
{
	/// @desc Use a sprite as a stencil mask for future drawing. Use draw_clear_mask() to reset.
	/// @arg {sprite} sprite The sprite to use as a mask
	/// @arg {real} subimg The frame of the mask sprite
	/// @arg {real} x The x coordinate of where to draw the mask
	/// @arg {real} y The y coordinate of where to draw the mask
	/// @arg {bool} inverse If true, punches a hole through the mask instead
	/// @arg {real} alpha_threshold Transparency cutoff point. Anything under will be discarded
	
	draw_clear_mask();
	
	draw_mask_start();
	draw_sprite(sprite, subimg, x, y);
	draw_mask_end();
}
function draw_mask_start(inverse = false, alpha_threshold = 0.5)
{
	/// @desc Sets the drawing target to the stencil buffer. Make sure to use draw_mask_end() right after.
	/// @arg {bool} inverse If true, punches a hole through the mask instead
	/// @arg {real} alpha_threshold Transparency cutoff point. Anything under will be discarded
	
	if surface_exists(surface_get_target()) && !surface_has_depth(surface_get_target())
	{
		var surface_name = "Application surface";
		if surface_get_target() != application_surface
			surface_name = string("Surface {0}", surface_get_target());
		show_debug_message("[WARN] {0} is missing stencil buffer, masking will not work", surface_name);
	}
	
	if !gpu_get_stencil_enable()
	{
		gpu_set_stencil_enable(true);
		draw_clear_stencil(inverse ? 1 : 0); // Zeroes out the stencil buffer
	}
	
	// Prepare stencil buffer
	gpu_set_stencil_func(cmpfunc_always); // Always pass as long as there's a pixel
	gpu_set_stencil_pass(stencilop_replace); // Start writing to the buffer
	gpu_set_stencil_ref(inverse ? 0 : 1); // Value to write
	
	gpu_push_state();
	gpu_set_alphatestenable(true);
	gpu_set_alphatestref(min(0xFF * alpha_threshold, 0xFF - 1)); // Pixels under this threshold will be discarded (won't exist)
	gpu_set_colorwriteenable(false, false, false, false); // Don't draw the mask sprite to the screen
}
function draw_mask_end()
{
	/// @desc Call this after drawing your stencil mask with draw_mask_start(). Future drawing operations will use the mask, until you call draw_clear_mask().
	
	gpu_pop_state();
	gpu_set_stencil_pass(stencilop_keep); // Stop writing to the stencil
	
	// Since each pixel wrote 1 to the buffer, now we can use the stencil as a mask
	gpu_set_stencil_ref(1); // Value to check against
	gpu_set_stencil_func(cmpfunc_equal); // From now on, only draw if the value at each position in the buffer is 1
}
function draw_clear_mask()
{
	/// @desc Disables the stencil mask.
	
	gpu_set_stencil_enable(false);
	draw_clear_stencil(0);
}

#endregion
