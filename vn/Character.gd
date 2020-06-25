extends Node2D

class_name Character

const MAX_CHARACTER_IN_SCREEN: float = 3.0

var _self
var _id: String
var _name: String
var _color: String
var _rect: TextureRect

func _init(context, id: String, name: String, color: String, texture: Texture):
	hide()
	z_index = 1
	position = Vector2(0, 0)
	
	_self = context
	_id = id
	_name = name
	_color = color
	_rect = TextureRect.new()
	_rect.texture = texture
	_rect.set_expand(true)
	_rect.set_stretch_mode(TextureRect.STRETCH_KEEP_ASPECT_COVERED)
	_rect.set_size(
		Vector2(OS.get_window_size().x * (1.0 / MAX_CHARACTER_IN_SCREEN),
		OS.get_window_size().y))
	
	add_child(_rect)
	
func set_texture(texture: Texture) -> void:
	_rect.texture = texture

func set_pos(pos: float) -> void:
	position.x = OS.get_window_size().x * pos

func set_flip(is_flip: bool) -> void:
	_rect.flip_h = is_flip
