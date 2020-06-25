extends Node2D

class_name TextBox

var _self
var _rect: TextureRect

func _init(context):
	z_index = 2
	
	_self = context
	_rect = TextureRect.new()
	_rect.texture = _self._textures["s_default_textbox_texture"]
	_rect.set_expand(true)
	_rect.set_stretch_mode(TextureRect.STRETCH_SCALE)
	_rect.set_size(Vector2(OS.get_window_size().x - 80, _rect.texture.get_size().y))
	_rect.set_position(Vector2(40, OS.get_window_size().y - _rect.texture.get_size().y - 40))
	
	add_child(_rect)
