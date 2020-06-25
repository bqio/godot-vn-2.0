extends Node2D

class_name Background

var _self
var _id
var _rect: TextureRect

func _init(context):
	hide()
	z_index = 0
	
	_self = context
	_rect = TextureRect.new()
	_rect.set_expand(true)
	_rect.set_stretch_mode(TextureRect.STRETCH_SCALE)
	_rect.set_size(Vector2(OS.get_window_size().x, OS.get_window_size().y))
	
	add_child(_rect)
	
